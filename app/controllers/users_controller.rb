class UsersController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]

  def new
    if current_user
      redirect_to tasks_path, alert: 'You are already logged in'
    else
      @user = User.new
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to tasks_path, notice: 'Successfully signed up!'
    else
      render :new
    end
  end
  

  def show
    @user = User.find(params[:id])
    if @user != current_user
      redirect_to tasks_path, alert: 'Access denied'
    else
    @tasks = @user.tasks
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
  end