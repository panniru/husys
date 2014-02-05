class RegistrationsController < ApplicationController
  before_action :load_registration , :only => [:exam, :review_exam ]

  def new
    @registration = Registration.new
    @categories = Course.distinct_categories
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
        render 'show'
      else
        flash[:fail] = I18n.t :fail, :scope => [:customer, :create]
        render "new"
      end
    else
      flash[:fail] = I18n.t :machine, :scope => [:customer, :create]
      render "new"
    end
  end

  def avalable_slots
    respond_to do |format|
      format.json do
        exam_center = ExamCenter.find(params[:exam_center_id])
        date = Date.strptime(params[:exam_date], '%m/%d/%Y').strftime("%Y-%d-%m")
        grid = RegistrationProcessor.prepare_grid(date, exam_center)
        puts "grid========>#{grid}"
        course = Course.find(params[:course_id])
        slots = RegistrationProcessor.matched_slots(grid, course.duration.to_i)
        puts "slots========>#{slots}"
        render :json => slots
      end
  end
  end

  def exam
    prev_questions = session[:current_user_exam_questions]
    puts "initial===============>#{prev_questions}"

    unless prev_questions.present?
      prev_questions = []
      session[:current_user_exam_questions] = prev_questions
    end

    prev_qtn = nil
    if params[:question_id].present?
      prev_questions.each do |qtn|
        if qtn.question_id.to_s == params[:question_id]
          prev_qtn = qtn
          break
        end
      end
      prev_qtn.answer_caught = params[:answer_caught]
    end

    if params[:action_for] == "prev"
      @question = prev_qtn.active_question_no ==1 ? prev_qtn : prev_questions[prev_questions.index(prev_qtn)-1]
    else
      if prev_qtn.present? and prev_questions[prev_questions.index(prev_qtn)+1].present?
        @question = prev_questions[prev_questions.index(prev_qtn)+1]
      else
        @course = @registration.course
        @question = RandomQuestionGenerator.generate_question(prev_questions, @course)
        prev_questions << @question
      end
    end
  end

  def review_exam
    @questions = session[:current_user_exam_questions]
  end

  private

  def registration_params
    params.require(:registration).permit(:exam_center_id, :course_id, :exam_date, :exam_start_time)
  end

  def load_registration
    @registration = Registration.find(params[:id])
  end

end
