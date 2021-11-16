class ApplicationController < ActionController::Base
  add_flash_types :success
  
  def after_sign_in_path_for(_resource)
    if current_user.admin?
      admin_home_index_path
    else
      root_path
    end
  end
end
