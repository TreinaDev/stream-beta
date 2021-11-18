class SubscriptionPlanValuesController < ApplicationController
  before_action :set_subscription_plan, only: %i[index new create]
  before_action :user_must_fill_profile

  def index
    @subscription_plan_values = @subscription_plan.subscription_plan_values
  end

  def new
    @subscription_plan_value = SubscriptionPlanValue.new
  end

  def create
    @subscription_plan_value = SubscriptionPlanValue.new(subscription_plan_values_params)
    @subscription_plan_value.subscription_plan = @subscription_plan

    if @subscription_plan_value.save
      redirect_to subscription_plan_subscription_plan_values_path, success: 'Preço dinâmico criado com sucesso!'
    else
      render :new
    end
  end

  private

  def subscription_plan_values_params
    params.require(:subscription_plan_value).permit(:start_date, :end_date, :value)
  end

  def set_subscription_plan
    @subscription_plan = SubscriptionPlan.find(params[:subscription_plan_id])
  end
end
