class Course < ActiveRecord::Base

  validates :category, :presence => true
  validates :sub_category, :presence => true
  validates :course_name, :presence => true
  validates :exam_name, :presence => true
  validates :duration, :presence => true
  validates :no_of_questions, :presence => true

  scope :grouped_category, { select: 'courses.category',
  group: 'courses.category'}
end
