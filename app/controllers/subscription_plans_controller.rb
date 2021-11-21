class SubscriptionPlansController < ApplicationController
  before_action :authenticate_admin!, only: %i[create new]
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

  def show
    @subscription_plan = SubscriptionPlan.find(params[:id])
  end

  private

  def subscription_plan_params
    params.require(:subscription_plan).permit(:title, :description, :value, :plan_type)
  end
end
