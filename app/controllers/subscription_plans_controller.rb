class SubscriptionPlansController < ApplicationController
  before_action :authenticate_admin!, only: %i[create new edit update inactive]
  before_action :user_must_fill_profile

  def index
    @subscription_plans = SubscriptionPlan.all
  end

  def new
    @subscription_plan = SubscriptionPlan.new
  end

  def create
    @subscription_plan = SubscriptionPlan.new(subscription_plan_params)

    if @subscription_plan.save
      redirect_to @subscription_plan, success: t('.success')
    else
      render :new
    end
  end

  def edit
    @subscription_plan = SubscriptionPlan.find(params[:id])
  end

  def update
    @subscription_plan = SubscriptionPlan.find(params[:id])

    redirect_to @subscription_plan, success: t('.success') if @subscription_plan.update(subscription_plan_params)
  end

  def show
    @subscription_plan = SubscriptionPlan.find(params[:id])
    @user_subscription_plan = current_user&.user_subscription_plans&.find_by(subscription_plan: @subscription_plan)
  end

  def inactive
    @subscription_plan = SubscriptionPlan.find(params[:id])

    @subscription_plan.inactive!
    redirect_to subscription_plan_path, success: t('.success')
  end

  private

  def subscription_plan_params
    params.require(:subscription_plan).permit(:title, :description, :value, :plan_type)
  end
end
