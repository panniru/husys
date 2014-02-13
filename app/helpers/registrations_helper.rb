module RegistrationsHelper

  def status(exam_date, strt_time, end_time)
    present_date = session[:system_date]
    status = ""
    if exam_date > present_date
      status = "scheduled"
      status = "Take Exam" if strt_time <= present_date.strftime("%H.%M") and end_time >= present_date.strftime("%H.%M")
    elsif
      status = "completed"
    end
  end
end
