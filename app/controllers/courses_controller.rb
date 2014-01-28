class CoursesController < ApplicationController
  before_action :load_course, :only => [:show, :update, :destroy]

  def index
    @courses = Course.group(:category)
  end

  def new
    @course = Course.new
  end

  def create
    @course = Course.create(course_params)
  end

  private

  def course_params
    params.require(:course).permit(:course_name, :category, :sub_course, :exam_name, :duration, :no_of_questions)
  end

  def load_course
    @course = Course.find(params[:id]).first
  end

end
