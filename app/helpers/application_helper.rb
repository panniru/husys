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
    list << home
    if current_user.admin?
      list << course_details
      list << exam_centers
      list << survey
      list << users
    elsif current_user.exam_center?
      exam_center = current_user.exam_center
      list << machines_availability(exam_center)
      list << machine_status(exam_center)
      list << survey
    elsif current_user.student?
      list << registrations
      list << results
    end
    list
  end

  def roles
    roles = []
    Role.order('role').all.each do |role|
      inner_role = []
      inner_role << role.role
      inner_role << role.id
      roles << inner_role
    end
    roles
  end


  def render_errors(obj)
    errors = []
    obj.errors.full_messages.each do |message|
      errors << content_tag("div", message, :class => "alert alert-danger")
    end
    raw(errors.join(""))
  end

  def machines_availability(exam_center)
    Struct.new(:icon, :item, :link, :is_active ).new('glyphicon glyphicon-search', 'Machine Availability', machine_availability_exam_center_path(exam_center), controller.action_name == "machine_availability")
  end

  def machine_status(exam_center)
    Struct.new(:icon, :item, :link, :is_active ).new('glyphicon glyphicon-credit-card', 'Machines', exam_center_machines_path(exam_center), controller.controller_name == "machines")
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
    Struct.new(:icon, :item, :link, :is_active).new('glyphicon glyphicon-calendar', 'Registrations', registrations_path, controller.controller_name == "registrations")
  end

  def results
    Struct.new(:icon, :item, :link, :is_active).new('glyphicon glyphicon-list-alt', 'Results', '#', false)
  end

  def home
    Struct.new(:icon, :item, :link, :is_active).new('glyphicon glyphicon-home', 'Home', root_path, is_home_active?)
  end

  def users
    Struct.new(:icon, :item, :link, :is_active).new('glyphicon glyphicon-user', 'Users', users_path, controller.controller_name == "users")
  end

  def is_home_active?
    (current_user.exam_center.present? and controller.controller_name == 'exam_centers' and controller.action_name == 'show') or controller.controller_name == "home"
  end


  def is_course_active?
    COURSE_CONROLLERS.include?(controller.class.name)
  end

  def is_exam_centers_active?
    EXAM_CENTERS_CONROLLERS.include?(controller.class.name)
  end

  def bread_crumbs
    list = []
    url_parts = request.fullpath[1, request.fullpath.length].split('/')
    url = ""
    url_parts.each do |part|
      url += "/#{part}"
      item = part.partition('?').first.titleize
      klass = url_parts.last == part ? 'active' : ''
      list << Struct.new(:item, :link, :klass).new( item, url, klass)
    end
    list
  end

end
