module ExamCentersHelper

  def exam_center_action_bar(center)
    buttons = []
    buttons << edit_exam_center(center) if can? :edit, ExamCenter
    buttons << delete_btn(center) if can? :destroy, ExamCenter
    buttons << machine_group(center) if can? :create, Machine
    content_tag(:div,raw(buttons.join(" ")))
  end

  def new_btn
    link_to "New Exam Center", new_exam_center_path, :class => "btn btn-primary"
  end

  private

  def edit_exam_center(center)
    link_to "Edit", edit_exam_center_path(center), :class => "btn btn-success"
  end

  def delete_btn(center)
    link_to "Delete", center, :class => "btn btn-danger", :data => { :confirm => 'Deleting the Exam Center will cause to delete all Machines in Center ', :method => :delete }
  end

  def machine_group(center)
    new = link_to "Add Machine", new_exam_center_machine_path(center), :class => "btn btn-primary"
    btn_group = "<div class='btn-group'>"
    btn_group += "#{new}"
    btn_group += "<button type='button' class='btn btn-primary dropdown-toggle' data-toggle='dropdown'><span class='caret'></span><span class='sr-only'>Toggle Dropdown</span></button>"
    btn_group += "<ul class='dropdown-menu' role='menu>"
    btn_group += "<li></li>"
    btn_group += "<li class='divider'></li>"
    btn_group += "<li><a href='#'>Machine Status</a></li>"
    btn_group += "<li class='divider'></li>"
    btn_group += "</ul>"
    btn_group += "</div>"
  end

  def machine_avialability(slot)
    klass = "label label-danger"
    icon = "glyphicon glyphicon-thumbs-down"
    if slot
      klass = "label label-success"
      icon = "glyphicon glyphicon-thumbs-up"
    end
    "<span class = '"+klass+"'><i class = 'icon-width "+icon+"'></i></span>"
  end



end
