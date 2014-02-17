class Ability
  include CanCan::Ability



  def initialize(user)
    alias_action :search, :machine_availability, :to => :read
    alias_action :upload_new, :upload, :to => :create
    alias_action :xls_template, :to => :read

    user ||= User.new
    if user.admin?
      can :manage, [Course, ExamCenter, Question, QuestionUploader]
      can :read, Machine
    elsif user.exam_center?
      can [:read], ExamCenter
      cam :manage, :Machine
    elsif user.student?
      can :manage, Registration
    end
  end
end
