class RegistrationsController < ApplicationController
  before_action :load_registration , :only => [:show, :exam, :review_exam, :submit_exam, :init_registration_show]

  def index
    @registrations = current_user.registrations
    @registrations = RegistrationsDecorator.decorate_collection(@registrations)
  end

  def show
    @registration = RegistrationsDecorator.decorate(@registration)
  end

  def new
    @registration = Registration.new
    @categories = [""]
    @categories.concat(Course.distinct_categories)
  end

  def create
    exam_center = ExamCenter.find(registration_params[:exam_center_id])
    grid = RegistrationProcessor.prepare_grid(registration_params[:exam_date], exam_center)
    course = Course.find(registration_params[:course_id])
    machine_id = RegistrationProcessor.best_fit_machine(grid, course.duration.to_i)
    if machine_id.present?
      end_time = registration_params[:exam_start_time].to_i + course.duration.to_i
      @registration = Registration.create(registration_params.merge!(:machine_id => machine_id, :student_id => current_user.id, :exam_end_time => end_time.to_s, :registration_date => session[:system_date]))
      if @registration.save
        redirect_to registrations_path
      else
        flash[:fail] = I18n.t :fail, :scope => [:registration, :create]
        render "new"
      end
    else
      flash[:fail] = I18n.t :machine, :scope => [:registration, :create]
      render "new"
    end
  end

  def avalable_slots
    respond_to do |format|
      format.json do
        exam_center = ExamCenter.find(params[:exam_center_id])
        date = Date.strptime(params[:exam_date], '%m/%d/%Y').strftime("%Y-%d-%m")
        grid = RegistrationProcessor.prepare_grid(date, exam_center)
        course = Course.find(params[:course_id])
        slots = RegistrationProcessor.matched_slots(grid, course.duration.to_i)
        render :json => slots
      end
    end
  end

  def exam
    selected_questions = session[:current_user_exam_questions]
    @course = @registration.course
    unless selected_questions.present?
      selected_questions = RandomQuestionGenerator.generate_questions(@course)
      session[:current_user_exam_questions] = selected_questions
    end
    @question = RandomQuestionGenerator.next_question(params, selected_questions)
    if @question.nil?
      redirect_to review_exam_registration_path(@registration)
    end
  end

  def init_registration_show
    if @registration.exam_date.to_date == session[:system_date].to_date
      start_time = @registration.exam_start_time.strftime("%H.%M").to_f - 10.0
      end_time = @registration.exam_end_time.strftime("%H.%M").to_f
      system_time = session[:system_date].strftime("%H.%M").to_f
      if start_time <= system_time or system_time <= end_time
      else
        render "show"
      end
    else
      @registration = RegistrationsDecorator.decorate(@registration)
      render "exam_land" #"show"
    end
  end

  def review_exam
    @questions = session[:current_user_exam_questions]
  end

  def submit_exam
    active_questions = session[:current_user_exam_questions]
    if active_questions.present?
      validator = ExamValidator.new(active_questions, @registration.id, @registration.course)
      result = validator.validate
      redirect_to @registration
    else
      flash[:fail] = I18n.t :fail, :scope => [:registration, :exam]
    end
  end

  private

  def registration_params
    params.require(:registration).permit(:exam_center_id, :course_id, :exam_date, :exam_start_time)
  end

  def load_registration
    @registration = Registration.find(params[:id])
  end

end
