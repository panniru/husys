class Registration < ActiveRecord::Base

  attr_accessor :category, :sub_category, :course_name

  validates :exam_start_time, :presence => true
  validates :exam_center, :presence => true
  validates :course, :presence => true
  validates :machine, :presence => true
  validate :exam_date_validation

  belongs_to :exam_center
  belongs_to :course
  belongs_to :machine
  belongs_to :student, :class_name => "User", foreign_key: "student_id"
  has_one :result

  scope :dated_on, lambda {|date| where("exam_date = ?", date)}

  private

  def exam_date_validation
    unless exam_date.present? and exam_date.to_date >= DateTime.now.to_date
      self.errors.add(:exam_date, I18n.t(:exam_date, :scope => [:registration, :create]) )
    end
  end

end
