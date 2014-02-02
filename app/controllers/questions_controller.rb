class QuestionsController < ApplicationController

  before_action :load_course
  before_action :load_question, :only => [:show, :edit, :update, :destroy]

  def index
    @questions = @course.questions.order("id DESC")
  end

  def new
    @question = @course.new_question
  end

  def create
    @question = @course.add_question(question_params)
    if @question.save
      render "show"
    else
      render "new"
    end
  end

  def update
    if @question.update(question_params)
      render "show"
    else
      render "edit"
    end
  end

  def upload_new
    @upload_question = QuestionUploader.new()
    @upload_question.course_id = params[:course_id]
  end

  def upload
    @upload_question = QuestionUploader.new(params[:question_uploader])
    if @upload_question.save
    else
      render "upload_new"
    end
  end

  private

  def load_course
    @course = Course.find(params[:course_id])
  end

  def load_question
    @question = @course.questions.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:description, :option_1, :option_2, :option_3, :option_4, :answer)
  end

end
