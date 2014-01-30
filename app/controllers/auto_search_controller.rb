class AutoSearchController < ApplicationController
  skip_authorization_check

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

  def get_autocomplete_items(parameters)
    items = super(parameters)
  end
end
