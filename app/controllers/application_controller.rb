class ApplicationController < ActionController::Base
  add_flash_types :success

  def after_sign_in_path_for(resource)
    if current_user.admin?
      stored_location_for(resource) || admin_home_index_path
    else
      stored_location_for(resource) || root_path
    end
  end

  private

  def authenticate_admin!
    if current_user
      redirect_to root_path unless current_user.admin?
    else
      redirect_to new_user_session_path
    end
  end
end
