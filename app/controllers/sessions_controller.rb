class SessionsController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]
  def new
  end

  def create
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      if user.admin?
        redirect_to admin_users_path, notice: 'Logged in as Admin!'
      else
        redirect_to tasks_path, notice: 'Logged in!'
      end
    else
      flash.now[:alert] = 'Invalid email/password combination'
      render :new
    end
  end
  

  def destroy
    session.delete(:user_id)
    redirect_to login_path, notice: 'Logged out!'
  end
end
