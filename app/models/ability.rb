class Ability
  include CanCan::Ability



  def initialize(user)
    alias_action :search, :machine_availability, :hierarchy, :today_exams,  :to => :read
    alias_action :upload_new, :upload, :to => :create
    alias_action :xls_template, :to => :read

    user ||= User.new
    if user.admin?
      can :manage, [Course, ExamCenter, Question, QuestionUploader, User, DescriptiveQuestion]
      can :read, Machine
    elsif user.exam_center?
      can [:read], ExamCenter
      can :manage, Machine
    elsif user.student?
      can :read, Course
      can :manage, Registration
    end
  end
end
