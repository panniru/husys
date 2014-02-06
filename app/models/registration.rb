class Registration < ActiveRecord::Base

  attr_accessor :category, :sub_category, :course_name

  belongs_to :exam_center
  belongs_to :course
  belongs_to :machine
  belongs_to :student, :class_name => "User", foreign_key: "student_id"
  has_one :result

  scope :dated_on, lambda {|date| where("exam_date = ?", date)}

end
