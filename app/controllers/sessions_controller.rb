class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(username: params[:username])

    if user.present? && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_path
    else
      redirect_to sessions_new_url, notice: "login failed, please try again"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to sign_in_path
  end
end