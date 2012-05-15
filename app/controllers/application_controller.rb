class ApplicationController < ActionController::Base
  before_filter :session_count

  include ControllerAuthentication
  protect_from_forgery
  helper_method :current_user

  def session_count
    if (logged_in? && session[:count] <= 2)
      session[:count] += 1
      
    elsif (logged_in? && session[:count] > 2)
      redirect_to prompt_sessions_path, :alert => "You must enter Password to Continue"
    end
  end
  
end
  
