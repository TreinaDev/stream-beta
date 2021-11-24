class UserPaymentMethod
  attr_accessor :cpf, :payment_type, :card_number, :cvv_number, :expiry_date
  attr_reader :attribute_errors

  def initialize(params = {})
    @attribute_errors = []

    @cpf = params['cpf']
    @payment_type = params['payment_type']

    return unless @payment_type == 'credit_card'

    @card_number = params['card_number'] || ''
    @cvv_number = params['cvv_number'] || ''
    @expiry_date = params['expiry_date'] || ''
  end

  def valid?
    validate_cpf
    validate_payment_type
    validate_credit_card if payment_type == 'credit_card'

    @attribute_errors.empty?
  end

  private

  def validate_cpf
    @attribute_errors << 'CPF não é válido' unless CPF.valid?(cpf)
  end

  def validate_payment_type
    @attribute_errors << 'Tipo de pagamento não é válido' unless %w[pix boleto credit_card].include?(payment_type)
  end

  def validate_credit_card
    unless card_number.match?(/\A\d{16}\z/)
      @attribute_errors << "#{I18n.t('payment_methods.new.card_number')} #{I18n.t('errors.messages.invalid')}"
    end

    unless cvv_number.match?(/\A\d{3}\z/)
      @attribute_errors << "#{I18n.t('payment_methods.new.cvv_number')} #{I18n.t('errors.messages.invalid')}"
    end

    return if expiry_date.match?(%r{\A\d{2}/\d{2}\z})

    @attribute_errors << "#{I18n.t('payment_methods.new.expiry_date')} #{I18n.t('errors.messages.invalid')}"
  end
end
