class ApplicationController < ActionController::Base
  helper_method :current_user
  before_action :require_login

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  private

  def require_login
    unless current_user
      flash[:alert] = 'You must be logged in to access this section'
      redirect_to login_path
    end
  end
end
