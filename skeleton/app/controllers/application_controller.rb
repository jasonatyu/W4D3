class ApplicationController < ActionController::Base
  helper_method :current_user, :login_user!, :logged_in?

  def current_user 
    @current_user ||= User.find_by(session_token: session[:session_token])
  end 

  def login_user!
    session_token = @user.reset_session_token
    session[:session_token] = session_token
    redirect_to cats_url
  end

  def logged_in?
    !!(current_user)
  end

end
