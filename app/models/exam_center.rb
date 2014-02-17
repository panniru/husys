WillPaginate.per_page = 10
class ExamCenter < ActiveRecord::Base

  geocoded_by :full_address   # can also be an IP address
  before_validation :geocode
  validates :center_name, :presence=> true
  validates :address_line1, :presence=> true
  validates :latitude, :numericality => true
  validates :longitude, :numericality => true

  attr_accessor :assigned_user
  has_many :machines
  has_many :registrations
  has_one :user, :class_name => "User", :foriegn_key => "assigned_user_id"

  def address_list
    address =[]
    address << self.address_line1
    address << self.address_line2
    address << self.city
    address << self.state
    address << self.country
  end

  def full_address
    address_list.join(" ")
  end

  def full_address_html
    address_list.join("<br/>")
  end

  def name_and_address_line1
    "#{center_name} #{address_line1}"
  end

  def new_machine
    machine = Machine.new
    machine.exam_center = self
    machine
  end

  def add_machine(params)
    machine = Machine.new(params)
    machine.exam_center = self
    machine
  end

end
