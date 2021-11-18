class ApplicationController < ActionController::Base
  add_flash_types :success

  def after_sign_in_path_for(_resource)
    if current_user.admin?
      admin_home_index_path
    else
      root_path
    end
  end

  private

  def require_admin_login
    return if current_user&.admin?

    redirect_to root_path, notice: 'Acesso não autorizado!'
  end

  def user_must_fill_profile
    return if current_user&.user_profile || current_user&.admin?

    redirect_to new_user_profile_path, notice: 'Preencha seu perfil para continuar navegando'
  end
end
