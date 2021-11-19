class PaymentMethodsController < ApplicationController
  before_action :authenticate_admin!, only: %i[new create show]

  def new
    @payment_method = PaymentMethod.new
  end

  def create
    @payment_method = PaymentMethod.new
    @payment_method.token = send_payment_method_to_pagamantos_beta
    @payment_method.user = current_user
    if @payment_method.save
      redirect_to @payment_method, success: t('.success')
    else
      @error = t('.error')
      render :new
    end
  end

  def show
    PaymentMethod.find(params[:id])
  end

  private

  def send_payment_method_to_pagamantos_beta; end
end
