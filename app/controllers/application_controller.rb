class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :set_current_user

  def after_sign_in_path_for(resource)
    if resource.class != AdminUser
      dashboard_path
    else
      admin_root_path
    end
  end


private

  def set_current_user
    return true unless session[:user_id]
    @current_user ||= User.find(session[:user_id])
  end

end
