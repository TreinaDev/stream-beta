class SubscriptionPlansController < ApplicationController
  before_action :authenticate_admin!, only: %i[new create edit update inactive]
  before_action :user_must_fill_profile
  before_action :set_subscription_plan, only: %i[show add_promotion_ticket]
  before_action :test_maximum_uses_zero_or_nil, only: %i[add_promotion_ticket]

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
    @subscription_plan_value = @subscription_plan.subscription_plan_values
    @user_subscription_plan = current_user&.user_subscription_plans&.find_by(subscription_plan: @subscription_plan)
    @promotion_ticket = PromotionTicket.all
  end

  def add_promotion_ticket
    @subscription_plan.promotion_ticket = PromotionTicket.find_by!(title: params[:promotion_ticket][:title])
    redirect_to @subscription_plan, success: t('.success')
  end

  def inactive
    @subscription_plan = SubscriptionPlan.find(params[:id])

    @subscription_plan.inactive!
    redirect_to subscription_plan_path, success: t('.success')
  end

  def cancel
    @user_subscription_plan = UserSubscriptionPlan.find(params[:id])

    @user_subscription_plan.canceled!
    redirect_to user_my_subscription_plans_path, success: t('.success')
  end

  def reactive
    @user_subscription_plan = UserSubscriptionPlan.find(params[:id])

    @user_subscription_plan.active!
    redirect_to user_my_subscription_plans_path, success: t('.success')
  end

  private

  def subscription_plan_params
    params.require(:subscription_plan).permit(:title, :description, :value, :plan_type)
  end

  def set_subscription_plan
    @subscription_plan = SubscriptionPlan.find(params[:id])
  end

  def test_maximum_uses_zero_or_nil
    promotion_ticket = PromotionTicket.find_by(title: params[:promotion_ticket][:title])
    if promotion_ticket.nil?
      redirect_to @subscription_plan, notice: t('.fails')
    elsif promotion_ticket.maximum_uses.zero?
      redirect_to @subscription_plan, notice: t('.maximum_uses_zero')
    end
  end
end
