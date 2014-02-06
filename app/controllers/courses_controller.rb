class CoursesController < ApplicationController
  before_action :load_course, :only => [:show, :update, :destroy]

  def index
    @courses = Course.grouped_category
  end

  def show
  end

  def hierarchy
    respond_to do |format|
      format.json do
        hir_seq = ["category", "sub_category", "course_name"]
        if params[:filters].present?
          filters = params[:filters].split(',')
          wher_clause = {}
          filters.each.with_index {|x,i| wher_clause[hir_seq[i]] = x }
          @courses = Course.where(wher_clause)
          @courses = @courses.grouped_courses(params[:view_by]) if params[:view_by].present?

          data = CoursePresenter.new(@courses).hierachy_elements(params[:view_by])
          render :json => data
        end
      end
    end
  end

  def new
    @course = Course.new
  end

  def create
    @course = Course.create(course_params)
    if @course.errors.present?
      render "new"
    else
      render "show"
    end
  end

  def search
    @courses = Course.where("exam_name = ?", params[:search])
    render "course_grid"
  end

  private

  def course_params
    params.require(:course).permit(:course_name, :category, :sub_category, :exam_name, :duration, :no_of_questions, :pass_criteria_1, :pass_text_1, :pass_criteria_2, :pass_text_2, :pass_criteria_3, :pass_text_3, :pass_criteria_4, :pass_text_4)
  end

  def load_course
    @course = Course.find(params[:id])
  end

end
