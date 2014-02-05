class SessionsController  < Devise::SessionsController
  def create
    session[:system_date] = Date.today
    super
  end
end
