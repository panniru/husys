class Course < ActiveRecord::Base

  validates :category, :presence => true
  validates :sub_category, :presence => true
  validates :course_name, :presence => true
  validates :exam_name, :presence => true
  validates :duration, :presence => true
  validates :no_of_questions, :presence => true

  has_many :questions
  has_many :registraions

  scope :grouped_category, lambda { select('courses.category').group('courses.category')}

  scope :grouped_courses,  lambda {|group_by| select(group_by).group(group_by) }

  def new_question
    question = Question.new
    question.course = self
    question
  end

  def add_question(params)
    question = Question.new(params)
    question.course = self
    question
  end

  def self.distinct_categories
    categories = []
    self.grouped_courses('category').order('category asc').each  do |cat|
      categories << cat.category
    end
    categories
  end

end
