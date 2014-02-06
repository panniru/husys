class RegistrationsDecorator < Draper::Decorator
  delegate_all

  def course_name
    course.exam_name
  end

  def center_name
    exam_center.center_name
  end

  def duration
    "#{course.duration} Hrs"
  end

  def formatted_exam_date
    exam_date.strftime("%d-%m-%Y")
  end

  def formatted_registration_date
    registration_date.strftime("%d-%m-%Y")
  end

  def exam_time
    exam_start_time
  end

  def count_exam_date
    exam_date.strftime("%Y/%d/%m")
  end

  def status
  end

  def course_details
    "Category: #{course.category} <br\> Sub-Category: #{course.sub_category} <br\> Course: #{course.course_name}"
  end

  def center_address
    exam_center.full_address_html
  end

end
