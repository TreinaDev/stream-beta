class UserPaymentMethod
  attr_accessor :cpf, :payment_type, :card_number, :cvv_number, :expiry_date

  def initialize(params)
    @cpf = params['cpf']
    @payment_type = params['payment_type']

    if @payment_type == 'credit_card'
      @card_number = params['card_number']
      @cvv_number = params['cvv_number']
      @expiry_date = params['expiry_date']
    end
  end
end
