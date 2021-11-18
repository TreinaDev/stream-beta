class PaymentMethodsController < ApplicationController
  def new
    @payment_method = PaymentMethod.new
  end

  def create
    @payment_method = PaymentMethod.new
    @payment_method.token = send_payment_method_to_pagamantos_beta
    @payment_method.user = current_user
    @payment_method.save
    redirect_to @payment_method, success: t('.success')
  end

  def show
    PaymentMethod.find(params[:id])
  end

  private

  def send_payment_method_to_pagamantos_beta; end
end
