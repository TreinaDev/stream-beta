class UserSubscriptionPlansController < ApplicationController
  before_action :authenticate_user!
  before_action :user_must_fill_profile
  before_action :set_subscription_plan

  def new
    @user_subscription_plan = UserSubscriptionPlan.new
  end

  def create
    byebug
    # @user_subscription_plan = current_user.user_subscription_plans.new(subscription_plan: @subscription_plan)
    # @user_subscription_plan = current_user.user_subscription_plans.new(user_subscription_plan_params)
    UserSubscriptionPlan.new(user_subscription_plan_params)
    byebug

    if @user_subscription_plan.save
      @user_subscription_plan.confirm_payment

      redirect_to @subscription_plan
    else
      flash[:alert] = 'Erro ao registrar assinatura'
      render :new
    end
  end

  private

  def user_subscription_plan_params
    byebug
    params.require(:user_subscription_plan).permit(:product_token, :payment_method_token, :subscription_plan_id)
  end

  def set_subscription_plan
    byebug
    subscription_plan_id = params[:user_subscription_plan][:subscription_plan_id] || params[:subscription_plan][:id]
    @subscription_plan = SubscriptionPlan.find(subscription_plan_id)
  end
end
