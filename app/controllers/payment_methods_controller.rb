class PaymentMethodsController < ApplicationController
  before_action :authenticate_user!
  before_action :user_must_fill_profile
  before_action :deny_admin_access, only: %i[new create show]
  before_action :set_available_payment_methods, only: %i[new]

  def new
    @payment_method = PaymentMethod.new
  end

  def create
    @payment_method = current_user.payment_methods.new(payment_method_params)
    @user_payment_method = UserPaymentMethod.new(user_payment_method_params)
    @payment_method.user_payment_method = @user_payment_method

    if @payment_method.save
      redirect_to @payment_method, success: t('.success')
    else
      flash[:alert] = t('.error')
      render :new
    end
  end

  def show
    @payment_method = PaymentMethod.find(params[:id])
  end

  private

  def payment_method_params
    params.require(:payment_method).permit(:payment_type)
  end

  def user_payment_method_params
    user_params = params.require(:payment_method).permit(:card_operator, :payment_type, :card_number, :cvv_number,
                                                         :expiry_date)
    user_params.merge({ cpf: current_user.user_profile.cpf })
  end

  def set_available_payment_methods
    @available_payment_methods = PaymentMethod.available_payment_methods

    @available_payment_methods = [] unless @available_payment_methods.is_a? Array

    @available_payment_methods.map! { |apm| [I18n.t(apm), apm.to_sym] }

    flash[:alert] = t('.no_payment_methods_available') if @available_payment_methods.empty?
  end
end
