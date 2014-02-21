class RegistrationsController < ApplicationController
  before_action :load_registration , :only => [:show, :exam, :review_exam, :submit_exam, :init_registration_show, :validate_exam_entrance]
  before_action :validate_exam_status, :only => [:exam, :init_registration_show, :review_exam]
  authorize_resource

  def index
    @registrations = current_user.registrations.limit(50)
    @active_registrations = []
    @closed_registrations = []
    @registrations.each do |reg|
      @registration = reg
      validate_exam_status
      if reg.status == "pending" or reg.status == "seeded"
        @active_registrations << reg
      else
        @closed_registrations << reg
      end
    end
    @active_registrations = RegistrationsDecorator.decorate_collection(@active_registrations)
    @closed_registrations = RegistrationsDecorator.decorate_collection(@closed_registrations)
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
    date = Date.strptime(registration_params[:exam_date], "%d/%m/%Y")
    reg_processor = RegistrationProcessor.new(date, exam_center)
    reg_processor.prepare_grid
    #grid = RegistrationProcessor.prepare_grid(registration_params[:exam_date], exam_center)
    course = Course.find(registration_params[:course_id])
    machine_id = reg_processor.best_fit_machine(registration_params[:exam_start_time], course.duration.to_i)
    if machine_id.present?
      end_time = registration_params[:exam_start_time].to_i + course.duration.to_i
      @registration = Registration.create(registration_params.merge!(:machine_id => machine_id, :student_id => current_user.id, :exam_end_time => end_time.to_s, :registration_date => session[:system_date]))
      @registration.mark_pending
      if @registration.save
        redirect_to registrations_path
      else
        @categories = [""]
        @categories.concat(Course.distinct_categories)
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
        date = Date.strptime(params[:exam_date], "%d/%m/%Y")
        reg_processor = RegistrationProcessor.new(date, exam_center)
        reg_processor.prepare_grid
        course = Course.find(params[:course_id])
        slots = reg_processor.matched_slots(course.duration.to_i)
        render :json => slots
      end
    end
  end

  def exam
    if @exam_status
      selected_questions = session[:current_user_exam_questions]
      @course = @registration.course
      @registration = RegistrationsDecorator.decorate(@registration)
      unless selected_questions.present?
        selected_questions = RandomQuestionGenerator.generate_questions(@course)
        session[:current_user_exam_questions] = selected_questions
      end
      @question = RandomQuestionGenerator.next_question(params, selected_questions)
      if @question.nil?
        redirect_to review_exam_registration_path(@registration)
      end
    else
      redirect_to submit_exam_registration_path(@registration)
    end
  end

  def init_registration_show
    if @registration.demo_registration?
      @registration.do_demo_initial_settings(DateTime.now)
    end
    @registration = RegistrationsDecorator.decorate(@registration)
    if @exam_status or @registration.demo_registration?
      render "exam_land"
    else
      render "show"
    end
  end

  def review_exam
    if @exam_status
      @questions = session[:current_user_exam_questions]
    else
      redirect_to submit_exam_registration_path(@registration)
    end
  end

  def submit_exam
    active_questions = session[:current_user_exam_questions]
    if active_questions.present?
      validator = ExamValidator.new(active_questions, @registration, @registration.course)
      result = validator.validate
      redirect_to @registration
    else
      flash[:fail] = I18n.t :fail, :scope => [:registration, :exam]
    end
  end

  def validate_exam_entrance
    respond_to do |format|
      format.json do
        status = false
        if @registration.access_password == params[:password]
          status = true
        end
        render :json => status
      end
    end
  end

  private

  def registration_params
    params.require(:registration).permit(:exam_center_id, :course_id, :exam_date, :exam_start_time)
  end

  def load_registration
    @registration = Registration.find(params[:id])
  end

  def validate_exam_status
    @exam_status = false
    system_time = Time.now

    if @registration.exam_date.to_date == system_time.to_date
      start_time = Time.new(@registration.exam_date.year, @registration.exam_date.month, @registration.exam_date.day, @registration.exam_start_time.strftime("%H"), @registration.exam_start_time.strftime("%M"))
      end_time = Time.new(@registration.exam_date.year, @registration.exam_date.month, @registration.exam_date.day, @registration.exam_end_time.strftime("%H"), @registration.exam_end_time.strftime("%M"))
      if ((start_time -  system_time)/60) <= 10.00 and system_time <= end_time
        @exam_status = true
      end
    end
  end
end
