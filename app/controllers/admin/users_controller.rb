class Admin::UsersController < ApplicationController
  before_action :require_admin

  def index
    @users = User.includes(:tasks).all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_users_path, notice: "User was successfully created."
    else
      render :new
    end
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to admin_users_path, notice: "User was successfully updated."
    else
      render :edit
    end
  end
  
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_users_path, notice: "User was successfully destroyed."
  end

  private

  def require_admin
  unless current_user.admin?
  redirect_to tasks_path, alert: '管理者以外はアクセスできません'
  end
  end

    def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :admin)
    end
    end
