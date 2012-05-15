class SessionsController < ApplicationController
  skip_before_filter :session_count, :only => [:prompt, :ask_for_password]
  before_filter :logout_for_new_login, :only => :new

  def logout_for_new_login
    if logged_in?
      redirect_to students_path, :alert => "Please log out for new login"
    end
  end
  
  def new
  end

  def create
    user = User.authenticate(params[:login], params[:password])
    if user
      session[:user_id] = user.id
      session[:count] = 0
      redirect_to students_path, :notice => "Logged in successfully."
    else
      flash.now[:alert] = "Invalid login or password."
      render :action => 'new'
    end
    
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "You have been logged out."
  end

  def prompt
   
  end

  def ask_for_password
    user = User.authenticate(current_user.username, params[:password])
    if user
      session[:user_id] = user.id
      session[:count] = 0
      redirect_to students_url
    else
      redirect_to prompt_sessions_path, :alert => "Wrong Password! Please enter Correct Password to Continue"
    end
  end
  
end
