class UserSubscriptionPlansController < ApplicationController
  before_action :authenticate_user!
  before_action :user_must_fill_profile
  before_action :set_subscription_plan

  def new
    UserSubscriptionPlan.new
  end

  def create
    @user_subscription_plan = current_user.user_subscription_plans.new(subscription_plan: @subscription_plan)

    if @user_subscription_plan.validate_payment
      if @user_subscription_plan.save
        @user_subscription_plan.confirm_payment

        redirect_to @subscription_plan, notice: t('.success')
      else
        flash[:alert] = 'Erro ao registrar assinatura'
        render :new
      end
    else
      flash[:alert] = 'Pagamento não autorizado'
      render :new
    end
  end

  private

  def set_subscription_plan
    @subscription_plan = SubscriptionPlan.find(params[:subscription_plan][:id])
  end
end
