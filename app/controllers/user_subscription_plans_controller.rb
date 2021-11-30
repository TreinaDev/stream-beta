class UserSubscriptionPlansController < ApplicationController
  before_action :authenticate_user!
  before_action :user_must_fill_profile
  before_action :deny_admin_access
  before_action :set_subscription_plan

  def new
    @user_subscription_plan = UserSubscriptionPlan.new
  end

  def create
    @user_subscription_plan = current_user.user_subscription_plans.new(user_subscription_plan_params)

    return render :new unless @user_subscription_plan.save

    @user_subscription_plan.confirm_payment
    if @user_subscription_plan.subscription_plan.promotion_ticket.present?
      @promotion_ticket = @user_subscription_plan.subscription_plan.promotion_ticket
      @promotion_ticket.using_promotion_ticket
    end
    set_status_flash
    redirect_to @subscription_plan
  end

  private

  def user_subscription_plan_params
    params.require(:user_subscription_plan).permit(:product_token, :payment_method_token, :subscription_plan_id)
  end

  def set_subscription_plan
    subscription_plan_id = params[:subscription_plan_id] || params[:user_subscription_plan][:subscription_plan_id]
    @subscription_plan = SubscriptionPlan.find(subscription_plan_id)
  end

  def set_status_flash
    case @user_subscription_plan.status
    when 'pending'
      flash[:notice] = t('.pending')
    when 'approved'
      flash[:success] = t('.approved')
    when 'rejected'
      flash[:alert] = t('.rejected')
    end
  end
end
