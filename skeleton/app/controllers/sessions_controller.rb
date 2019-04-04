class SessionsController < ApplicationController
  before_action :required_logged_out, only: [:new, :create]

  def new
    render :new  
  end 

  def create 
    @user = User.find_by_credentials(params[:user][:username], params[:user][:password])

    if @user.nil?
      flash.now[:errors] = ['Invalid credentials.']
      render :new
    else
      login_user!
    end 
  end 

  def destroy
    current_user.reset_session_token if current_user 
    session[:session_token] = nil 
    current_user = nil
    redirect_to new_user_url
  end 

  def required_logged_out 
    if logged_in?
      redirect_to cats_url
    end
  end
  
end
