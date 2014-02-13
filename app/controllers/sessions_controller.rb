class SessionsController  < Devise::SessionsController
  def create
    session[:system_date] = DateTime.now
    super
  end
end
