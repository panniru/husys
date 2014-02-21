class RegistrationsDecorator < Draper::Decorator
  delegate_all

  def student_name
    student.name
  end

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
    exam_start_time.strftime("%H:%M")
  end

  def end_time
    exam_end_time.strftime("%H:%M")
  end

  def count_exam_date
    if Rails.env.production? #converting gmt to ist at heroku temporary fix
      ((Time.new(exam_date.year, exam_date.month, exam_date.day, exam_start_time.hour, exam_start_time.to_datetime.minute))+gmt_to_ist_differece.hours).strftime("%Y/%m/%d %H:%M")
    else
      "#{exam_date.strftime("%Y/%m/%d")} #{exam_start_time.strftime("%H:%M:%S")}"
    end
  end

  def count_down_exam_end_time
    if Rails.env.production? #converting gmt to ist at heroku temporary fix
      ((Time.new(exam_date.year, exam_date.month, exam_date.day, exam_end_time.hour, exam_end_time.to_datetime.minute))+gmt_to_ist_differece.hours).strftime("%Y/%m/%d %H:%M")
    else
      "#{@registration.exam_date.strftime("%Y/%m/%d")} #{@registration.exam_end_time.strftime("%H:%M:%S")}"
    end
  end

  def course_details
    "Category: #{course.category} <br\> Sub-Category: #{course.sub_category} <br\> Course: #{course.course_name}"
  end

  def center_address
    exam_center.full_address_html
  end

  private

  def gmt_to_ist_differece
    (530 - Time.now.strftime("%z").gsub("+","").to_f)/100
  end

end
