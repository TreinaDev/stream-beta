FactoryBot.define do
  factory :user_payment_method do
    cpf { CPF.generate }
    payment_type { '' }
    card_number { '' }
    cvv_number { '' }
    expiry_date { '' }

    trait :pix do
      payment_type { 'pix' }
    end

    trait :boleto do
      payment_type { 'boleto' }
    end

    trait :credit_card do
      payment_type { 'credit_card' }
      card_number { '1234567890123456' }
      cvv_number { '123' }
      expiry_date { '10/30' }
    end
  end
end
