class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :set_current_user

  def after_sign_in_path_for(resource)
    if resource.class == AdminUser
      admin_root_path
    else
      if resource.organization
        dashboard_path
      else
        new_organization_path
      end
    end
  end


private

  def set_current_user
    return true unless session[:user_id]
    @current_user ||= User.find(session[:user_id])
  end

end
