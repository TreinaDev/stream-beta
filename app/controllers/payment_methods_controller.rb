class PaymentMethodsController < ApplicationController
  before_action :authenticate_user!
  before_action :user_must_fill_profile

  def new
    @payment_method = PaymentMethod.new
  end

  def create
    @payment_method = current_user.payment_methods.new(payment_method_params)

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
end
