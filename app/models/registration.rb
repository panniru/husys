class Registration < ActiveRecord::Base

  attr_accessor :category, :sub_category, :course_name

  has_one :exam_center
  belongs_to :course
  has_one :machine
  belongs_to :student , :class_name => "User", foreign_key: "user_id"

  scope :dated_on, lambda {|date| where("exam_date = ?", date)}

end
