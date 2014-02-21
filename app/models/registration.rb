class Registration < ActiveRecord::Base

  attr_accessor :category, :sub_category, :course_name, :current_user_time

  validates :exam_start_time, :presence => true
  validates :exam_center, :presence => true
  validates :course, :presence => true
  validates :machine, :presence => true
  validate :exam_date_validation
  before_save :generate_access_password
  before_save :generate_registration_id

  belongs_to :exam_center
  belongs_to :course
  belongs_to :machine
  belongs_to :student, :class_name => "User", foreign_key: "student_id"
  has_one :result

  scope :dated_on, lambda {|date| where("exam_date = ?", date)}
  scope :search, lambda{|id| where(:id => id) }

  def encrypt_access_password(password)
    self.access_password = BCrypt::Password.create(password)
  end

  def match_access_password(password)
    BCrypt::Password.new(self.access_password) == password
  end

  def demo_registration?
    self.status == 'seeded'
  end

  def mark_pending
    self.status = 'pending'
  end

  def mark_close
    self.status = 'closed'
  end

  def do_post_result
    increment_attempts
    mark_close unless demo_registration?
  end

  def do_demo_initial_settings(date)
    self.exam_date = date
    end_time = (date.to_time+self.course.duration.hours).to_datetime.strftime("%H:%M")
    self.update!(:exam_start_time => date.strftime("%H:%M"), :exam_end_time => end_time)
  end


  private

  def increment_attempts
    self.no_of_attempts = self.no_of_attempts.nil? ? 1 : self.no_of_attempts+1
  end

  def exam_date_validation
    unless exam_date.present? and exam_date.to_date >= current_user_time.to_date
      self.errors.add(:exam_date, I18n.t(:exam_date, :scope => [:registration, :create]) )
    end
  end

  def generate_access_password
    unless demo_registration?
      range = [(0..9), ('A'..'Z')].map { |i| i.to_a }.flatten
      self.access_password = (0...8).map { range[rand(range.length)] }.join
    end
  end

  def generate_registration_id
    count = Registration.dated_on(current_user_time.to_date).count
    count = ((count+1).to_f/1000).to_s.split(".")[1]
    part_1 = ((self.exam_center.id.to_f%1000)/1000).to_s.split(".")[1]
    part_2 = self.registration_date.strftime("%m%d")
    self.registration_id = "#{part_1}#{part_2}#{count}"
  end

end
