module ExamCentersHelper

  def exam_center_action_bar
    buttons = []
    buttons << edit_btn
    buttons << delete_btn
    buttons << machine_group
    content_tag(:div,raw(buttons.join(" ")))
  end

  def new_btn
    link_to "New Exam Center", new_exam_center_path, :class => "btn btn-primary"
  end


  def edit_btn
    link_to "Edit", "#", :class => "btn btn-info"
  end

  def delete_btn
    link_to "Delete", "#", :class => "btn btn-danger"
  end

  def machine_group
    btn_group = "<div class='btn-group'>"
    btn_group += "<a href='#' class='btn btn-primary' >Add Machines</a>"
    btn_group += "<button type='button' class='btn btn-primary dropdown-toggle' data-toggle='dropdown'><span class='caret'></span><span class='sr-only'>Toggle Dropdown</span></button>"
    btn_group += "<ul class='dropdown-menu' role='menu>"
    btn_group += "<li></li>"
    btn_group += "<li class='divider'></li>"
    btn_group += "<li><a href='#'>Delete Machines</a></li>"
    #btn_group += "<li class='divider'></li>"
    btn_group += "</ul>"
    btn_group += "</div>"
  end

end
