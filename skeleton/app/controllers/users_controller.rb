class UsersController < ApplicationController
  before_action :required_logged_out, only: [:new, :create]
  def new
    @user = User.new
    
    render :new 
  end 

  def create
    @user = User.new(user_params)
    if @user.save
      session[:session_token] = @user.reset_session_token
      redirect_to cats_url
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end 
  end 

  def required_logged_out 
    if logged_in?
      redirect_to cats_url
    end
  end

  private 
  def user_params 
    params.require(:user).permit(:username, :password)
  end
end
