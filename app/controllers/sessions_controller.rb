class SessionsController < ApplicationController
  before_action :redirect_if_logged_in, only: [:new, :create]

  def new; end

  def create
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to new_email_path, notice: "Logged in!"
    else
      flash[:alert] = "Invalid email or password"
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "Logged out!"
  end

  private
  def redirect_if_logged_in
    redirect_to root_path, notice: "You're already logged in" if logged_in?
  end
end
