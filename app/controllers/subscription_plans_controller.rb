class SubscriptionPlansController < ApplicationController
  before_action :authenticate_admin!, only: %i[create new]
  before_action :user_must_fill_profile
  before_action :set_subscription_plan, only: %i[show add_promotion_ticket]

  def index
    @subscription_plans = SubscriptionPlan.all
  end

  def new
    @subscription_plan = SubscriptionPlan.new
  end

  def create
    @subscription_plan = SubscriptionPlan.new(subscription_plan_params)
    @subscription_plan.request_token

    if @subscription_plan.save
      redirect_to @subscription_plan, success: t('.success')
    else
      render :new
    end
  end

  def show
    @subscription_plan_value = @subscription_plan.subscription_plan_values
    @user_subscription_plan = current_user&.user_subscription_plans&.find_by(subscription_plan: @subscription_plan)
    @promotion_ticket = PromotionTicket.all
  end

  def add_promotion_ticket
    if PromotionTicket.find_by(title: params[:promotion_ticket][:title]).nil?
      @promotion_ticket = PromotionTicket.all
      redirect_to @subscription_plan, notice: t('.fails')
    else
      @subscription_plan.promotion_ticket = PromotionTicket.find_by!(title: params[:promotion_ticket][:title])
      #test_maximum_uses_zero              em progresso
      redirect_to @subscription_plan, success: t('.success') if @subscription_plan.promotion_ticket.valid?
      redirect_to @subscription_plan, notice: t('.fails') unless @subscription_plan.promotion_ticket.valid?
    end
  end

  private

  def subscription_plan_params
    params.require(:subscription_plan).permit(:title, :description, :value, :plan_type)
  end

  def set_subscription_plan
    @subscription_plan = SubscriptionPlan.find(params[:id])
  end

  def confirm_maximum_uses_greater_than_zero(promotion_ticket)
    promotion_ticket.test_if_maximum_uses_is_greater_than_zero(promotion_ticket)
  end
end
