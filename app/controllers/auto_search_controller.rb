class AutoSearchController < ApplicationController
  skip_authorization_check

  autocomplete :exam_center, :center_name, :full => true, :extra_data => [:address_line1, :address_line2, :city, :state], :display_value => :name_and_address_line1

  autocomplete :user, :user_id, :full => true, :scope => [:exam_ceter_roles]

  def autocomplete_course_category
    term = params[:term]
    if term.present?
      items = Course.select('distinct category').where("lower(courses.category) ILIKE '%#{term}%'").order(:category)
    else
      items = {}
    end
    render :json => json_for_autocomplete(items, :category)
  end

  def autocomplete_course_sub_category
    term = params[:term]
    if term.present?
      items = Course.select('distinct sub_category').where("lower(courses.sub_category) ILIKE '%#{term}%'").order(:sub_category)
    else
      items = {}
    end
    render :json => json_for_autocomplete(items, :sub_category)
  end

  def autocomplete_course_course_name
    term = params[:term]
    if term.present?
      items = Course.select('distinct course_name').where("lower(courses.course_name) ILIKE '%#{term}%'").order(:course_name)
    else
      items = {}
    end
    render :json => json_for_autocomplete(items, :course_name)
  end

  def autocomplete_course_exam_name
    term = params[:term]
    if term.present?
      items = Course.select('distinct exam_name').where("lower(courses.exam_name) ILIKE '%#{term}%'").order(:exam_name)
    else
      items = {}
    end
    render :json => json_for_autocomplete(items, :exam_name)
  end


  def get_autocomplete_items(parameters)
    items = super(parameters)
  end
end
