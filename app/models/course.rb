class Course < ActiveRecord::Base

  scope :distinct_category, group(:category)
  scope :distinct_sub_course, group(:sub_course)
end
