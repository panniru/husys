module ApplicationHelper
  def navigation_list
    list = []
    if true #current_user.admin?
      list << course_details
      list << exam_centers
      list << upload_questions
      list << survey
    end
    list
  end

  def course_details
    Struct.new(:icon, :item, :link, :is_active ).new('glyphicon glyphicon-book', 'Course Details', '#', true)
  end

  def exam_centers
    Struct.new(:icon, :item, :link, :is_active).new('glyphicon glyphicon-list-alt', 'Exam Centers', '#', false)
  end

  def upload_questions
    Struct.new(:icon, :item, :link, :is_active).new('glyphicon glyphicon-upload', 'Upload Questions', '#', false)
  end

  def survey
    Struct.new(:icon, :item, :link, :is_active).new('glyphicon glyphicon-filter', 'Survey', '#', false)
  end
end
