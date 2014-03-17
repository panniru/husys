class QuestionsController < ApplicationController
  before_action :load_course
  before_action :load_question, :only => [:show, :edit, :update, :destroy]
  authorize_resource

  def index
    page = params[:page].present? ? params[:page] : 1
    @title = "Questions"
    @view = params[:view]
    if @view.present? and @view == "descriptive"
      @title = "Descriptive Questions"
    else
      @questions = @course.questions.order("id DESC").paginate(:page => page)
    end
  end

  def new
    @question = @course.new_question
  end

  def create
    @question = @course.add_question(question_params)
    if @question.save
      flash.now[:success] = I18n.t :success, :scope => [:question, :create]
      render "show"
    else
      flash.now[:fail] = I18n.t :fail, :scope => [:question, :create]
      render "new"
    end
  end

  def update
    if @question.update(question_params)
      flash.now[:success] = I18n.t :success, :scope => [:question, :update]
      render "show"
    else
      flash.now[:fail] = I18n.t :fail, :scope => [:question, :update]
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
      flash[:success] = I18n.t :success, :scope => [:question, :upload]
      redirect_to course_questions_path(@course)
    else
      render "upload_new"
    end
  end

  def xls_template
    respond_to do |format|
      @question = Question.new
      format.xlsx { send_data @question.xls_template(col_sep: "\t")}
    end
  end

  def destroy
    if @question.destroy
      flash[:success] = I18n.t :success, :scope => [:question, :destroy]
      redirect_to course_questions_path
    else
      flash.now[:fail] = I18n.t :fail, :scope => [:question, :destroy]
      render "show"
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
    params.require(:question).permit(:description, :option_1, :option_2, :option_3, :option_4, :answer, :is_descriptive)
  end

end
