class PromotionTicketsController < ApplicationController
  before_action :authenticate_admin!, only: %i[new create]
  def index
    @promotion_tickets = PromotionTicket.all
  end

  def new
    @promotion_ticket = PromotionTicket.new
  end

  def create
    @promotion_ticket = PromotionTicket.new(promotion_ticket_params)
    if @promotion_ticket.save
      redirect_to promotion_tickets_path, success: t('.success')
    else
      render :new
    end
  end

  private

  def promotion_ticket_params
    params.require(:promotion_ticket).permit(:title, :discount, :start_date,
                                             :end_date, :maximum_value_reduction, :maximum_uses)
  end
end
