class CoursePresenter

  HIERARCHY_SEQ = ['category', 'sub_category', 'course_name', 'exam_name']

  def initialize(courses = [])
    @courses = courses
  end

  def hierachy_elements(column)
    elements = []
    @courses.each do |course|
      next_col = nil
      if column.present? and HIERARCHY_SEQ.last != column
        next_col = HIERARCHY_SEQ[HIERARCHY_SEQ.index(column).next]
      end
      elements << {id: course.id, value: course[column.to_sym], next_column: next_col}
    end
    elements
  end

end
