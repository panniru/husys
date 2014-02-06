module ApplicationHelper

  COURSE_CONROLLERS = ['CoursesController', 'QuestionsController']
  EXAM_CENTERS_CONROLLERS = ['ExamCentersController', 'MachinesController']

  def flash_alert_class(key)
    key = 'danger' if key == :error
    alert_class = ["alert"]
    if key.to_s == "fail"
      alert_class << "alert-danger"
    elsif key == :notice
      alert_class << "alert-info"
    else
      alert_class << "alert-#{key}"
    end
    alert_class.join(" ")
  end

  def navigation_list
    list = []
    if current_user.admin?
      list << course_details
      list << exam_centers
      list << survey
    elsif current_user.student?
      list << registrations
      list << results
    end
    list
  end

  def  render_errors( obj )
    errors = []
    obj.errors.full_messages.each do |message|
      errors << content_tag("div", message, :class => "alert alert-danger")
    end
    raw(errors.join(""))
  end

  def course_details
    Struct.new(:icon, :item, :link, :is_active ).new('glyphicon glyphicon-book', 'Course Details', courses_path, is_course_active?)
  end

  def exam_centers
    Struct.new(:icon, :item, :link, :is_active).new('glyphicon glyphicon-list-alt', 'Exam Centers', exam_centers_path, is_exam_centers_active?)
  end

  def upload_questions
    Struct.new(:icon, :item, :link, :is_active).new('glyphicon glyphicon-upload', 'Upload Questions', '#', false)
  end

  def survey
    Struct.new(:icon, :item, :link, :is_active).new('glyphicon glyphicon-filter', 'Survey', '#', false)
  end

  def registrations
    Struct.new(:icon, :item, :link, :is_active).new('glyphicon glyphicon-calendar', 'Registrations', registrations_path, true)
  end

  def results
    Struct.new(:icon, :item, :link, :is_active).new('glyphicon glyphicon-list-alt', 'Results', '#', false)
  end

  def is_course_active?
    COURSE_CONROLLERS.include?(controller.class.name)
  end

  def is_exam_centers_active?
    EXAM_CENTERS_CONROLLERS.include?(controller.class.name)
  end

end
