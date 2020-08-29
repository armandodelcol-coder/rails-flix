class ApplicationController < ActionController::Base

  # By default, Rails supports setting the :notice and :alert flash types when calling the redirect_to method
  add_flash_types(:danger)

  private

  def require_signin
    unless current_user
      session[:intended_url] = request.url
      redirect_to new_session_url, alert: "Please sign in first!"
    end
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def current_user?(user)
    current_user == user
  end

  def require_admin
    unless current_user_admin?
      redirect_to root_url, alert: "Unauthorized access!"
    end
  end

  def current_user_admin?
    current_user && current_user.admin?
  end

  def require_correct_user
    @user = User.find(params[:id])
    redirect_to root_url unless current_user?(@user)
  end

  def require_correct_user_or_admin
    @user = User.find(params[:id])
    unless current_user_admin? || current_user?(@user)
      redirect_to root_url, alert: "Unauthorized access!"
    end
  end

  helper_method :current_user?,
                :current_user,
                :current_user_admin?

end
