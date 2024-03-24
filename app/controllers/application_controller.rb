class ApplicationController < ActionController::Base
  helper_method :current_user

  def current_user
    if session[:user_id]
      @current_user ||= User.find(session[:user_id])
    end
  end

  def require_login
      if current_user.nil?
      redirect_to posts_url, notice: "Login required"
    end
  end
end