class CoursesController < ApplicationController
  before_action :load_course, :only => [:show, :update, :destroy]

  def index
    @courses = Course.grouped_category
  end

  def new
    @course = Course.new
  end

  def create
    @course = Course.create(course_params)
  end

  private

  def course_params
    params.require(:course).permit(:course_name, :category, :sub_category, :exam_name, :duration, :no_of_questions, :pass_criteria_1, :pass_text_1, :pass_criteria_2, :pass_text_2, :pass_criteria_3, :pass_text_3, :pass_criteria_4, :pass_text_4)
  end

  def load_course
    @course = Course.find(params[:id]).first
  end

end
