class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :registerable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable, :trackable, :validatable, :timeoutable, :authentication_keys => [:user_id]
  validates :user_id, :presence => true, :uniqueness => true
  validates :email, :presence => true, :uniqueness => true
  validates :role_id, :presence => true
  belongs_to :role

  # def create
  #   User.create(user_params)
  # end

  def admin?
    self.role.role == 'admin'
  end

  def exam_center?
    self.role.role == 'exam_center'
  end

  def student?
    self.role.role == 'student'
  end

  private

  def user_params
    params.require(:user).permit(:user_id, :email, :role_id)
  end

end
