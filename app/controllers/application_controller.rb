class ApplicationController < ActionController::Base
  add_flash_types :success

  def after_sign_in_path_for(resource)
    if current_user&.admin?
      stored_location_for(resource) || admin_home_index_path
    else
      recurrent_payment
      stored_location_for(resource) || root_path
    end
  end

  def recurrent_payment
    plans = UserSubscriptionPlan.where(status_date: ..1.month.ago, enrollment: :active, user: current_user)
    plans.each(&:confirm_payment)
  end

  private

  def authenticate_admin!
    return if current_user&.admin?

    return redirect_to new_user_session_path unless user_signed_in?

    redirect_to root_path, notice: t('messages.unauthorized_access')
  end

  def deny_admin_access
    redirect_to admin_home_index_path, notice: t('messages.unauthorized_access') if current_user&.admin?
  end

  def user_must_fill_profile
    return unless user_signed_in?
    return if current_user&.user_profile || current_user&.admin?

    redirect_to new_user_profile_path, notice: 'Preencha seu perfil para continuar navegando'
  end
end
