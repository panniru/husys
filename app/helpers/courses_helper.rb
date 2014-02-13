module CoursesHelper

  def course_action_bar(course)
    buttons = []
    buttons << edit_course(course)
    buttons << delete_course(course)
    buttons << question_btn_group(course)
    content_tag(:div,raw(buttons.join(" ")))
  end

  def new_course
    link_to "New Course", new_course_path, :class => "btn btn-primary"
  end

  private
  def edit_course(course)
    link_to "Edit", edit_course_path(course), :class => "btn btn-success"
  end

  def delete_course(course)
    link_to "Delete", course, :class => "btn btn-danger", :data => { :confirm => 'Are You Sure ?', :method => :delete }
  end

  def question_btn_group(course)
    upload = link_to "Upload Questions", upload_new_course_questions_path(course)
    add = link_to "Add Question", new_course_question_path(course)
    show = link_to "Show Question", course_questions_path(course), :class => "btn btn-primary"
    btn_group = "<div class='btn-group'>"
    btn_group += "#{show}"
    btn_group += "<button type='button' class='btn btn-primary dropdown-toggle' data-toggle='dropdown'><span class='caret'></span><span class='sr-only'>Toggle Dropdown</span></button>"
    btn_group += "<ul class='dropdown-menu' role='menu>"
    btn_group += "<li></li>"
    btn_group += "<li class='divider'></li>"
    btn_group += "<li>#{upload}</li>"
    btn_group += "<li class='divider'></li>"
    btn_group += "<li>#{add}</li>"
    btn_group += "</ul>"
    btn_group += "</div>"
  end

end
