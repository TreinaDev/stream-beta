require 'rails_helper'

RSpec.describe UserPaymentMethod, type: :model do
  describe 'valid?' do
    context 'when payment_type is invalid' do
      subject { build(:user_payment_method, payment_type: 'other') }

      it do
        expect(subject.valid?).to be false
        expect(subject.attribute_errors).to include('Tipo de pagamento não é válido')
      end
    end

    context 'when payment_type is pix' do
      subject { build(:user_payment_method, :pix, cpf: cpf) }

      context 'and all fields are valid' do
        let(:cpf) { '79820202833' }

        it do
          expect(subject.valid?).to be true
          expect(subject.attribute_errors).to eq []
        end
      end

      context 'and there are invalid fields' do
        let(:cpf) { '12345678900' }

        it do
          expect(subject.valid?).to be false
          expect(subject.attribute_errors).to include('CPF não é válido')
        end
      end
    end

    context 'when payment_type is boleto' do
      subject { build(:user_payment_method, :boleto, cpf: cpf) }

      context 'and all fields are valid' do
        let(:cpf) { '79820202833' }

        it do
          expect(subject.valid?).to be true
          expect(subject.attribute_errors).to eq []
        end
      end

      context 'and there are invalid fields' do
        let(:cpf) { '12345678900' }

        it do
          expect(subject.valid?).to be false
          expect(subject.attribute_errors).to include('CPF não é válido')
        end
      end
    end

    context 'when payment_type is credit_card' do
      subject do
        build(:user_payment_method, :credit_card, cpf: cpf, card_number: card_number, cvv_number: cvv_number,
                                                  expiry_date: expiry_date)
      end

      context 'and all fields are valid' do
        let(:cpf) { '79820202833' }
        let(:card_number) { '1234567890123456' }
        let(:cvv_number) { '123' }
        let(:expiry_date) { '10/30' }

        it do
          expect(subject.valid?).to be true
          expect(subject.attribute_errors).to eq []
        end
      end

      context 'and there are invalid fields' do
        let(:cpf) { '12345678900' }
        let(:card_number) { '' }
        let(:cvv_number) { '' }
        let(:expiry_date) { '' }

        it do
          expect(subject.valid?).to be false
          expect(subject.attribute_errors).to include('CPF não é válido')
          expect(subject.attribute_errors).to include('Número do Cartão não é válido')
          expect(subject.attribute_errors).to include('Código de Segurança (CVV) não é válido')
          expect(subject.attribute_errors).to include('Validade (MM/AA) não é válido')
        end
      end
    end
  end

  describe 'validate_cpf' do
    subject { build(:user_payment_method, cpf: cpf) }

    context 'when :cpf is valid' do
      let(:cpf) { '79820202833' }

      it do
        expect(subject.valid?).to be false
        expect(subject.attribute_errors).to_not include('CPF não é válido')
      end
    end

    context 'when :cpf is not valid' do
      let(:cpf) { '12345678900' }

      it do
        expect(subject.valid?).to be false
        expect(subject.attribute_errors).to include('CPF não é válido')
      end
    end
  end

  describe 'validate_payment_type' do
    subject { build(:user_payment_method, payment_type: payment_type) }

    context 'when :payment_type is pix' do
      let(:payment_type) { 'pix' }

      it do
        expect(subject.valid?).to be true
        expect(subject.attribute_errors).to_not include('Tipo de pagamento não é válido')
      end
    end

    context 'when :payment_type is boleto' do
      let(:payment_type) { 'boleto' }

      it do
        expect(subject.valid?).to be true
        expect(subject.attribute_errors).to_not include('Tipo de pagamento não é válido')
      end
    end

    context 'when :payment_type is credit_card' do
      let(:payment_type) { 'credit_card' }

      it do
        expect(subject.valid?).to be false
        expect(subject.attribute_errors).to_not include('Tipo de pagamento não é válido')
      end
    end

    context 'when :payment_type is other' do
      let(:payment_type) { 'other' }

      it do
        expect(subject.valid?).to be false
        expect(subject.attribute_errors).to include('Tipo de pagamento não é válido')
      end
    end
  end

  describe 'validate_credit_card' do
    context ':card_number' do
      subject { build(:user_payment_method, :credit_card, card_number: card_number) }

      context 'when :card_number is valid' do
        let(:card_number) { '1234567890123456' }

        it do
          expect(subject.valid?).to be true
          expect(subject.attribute_errors).to_not include('Número do Cartão não é válido')
        end
      end

      context 'when :card_number is not valid' do
        let(:card_number) { '' }

        it do
          expect(subject.valid?).to be false
          expect(subject.attribute_errors).to include('Número do Cartão não é válido')
        end
      end
    end

    context ':cvv_number' do
      subject { build(:user_payment_method, :credit_card, cvv_number: cvv_number) }

      context 'when :cvv_number is valid' do
        let(:cvv_number) { '123' }

        it do
          expect(subject.valid?).to be true
          expect(subject.attribute_errors).to_not include('Código de Segurança (CVV) não é válido')
        end
      end

      context 'when :cvv_number is not valid' do
        let(:cvv_number) { '' }

        it do
          expect(subject.valid?).to be false
          expect(subject.attribute_errors).to include('Código de Segurança (CVV) não é válido')
        end
      end
    end

    context ':expiry_date' do
      subject { build(:user_payment_method, :credit_card, expiry_date: expiry_date) }

      context 'when :expiry_date is valid' do
        let(:expiry_date) { '10/30' }

        it do
          expect(subject.valid?).to be true
          expect(subject.attribute_errors).to_not include('Validade (MM/AA) não é válido')
        end
      end

      context 'when :expiry_date is not valid' do
        let(:expiry_date) { '' }

        it do
          expect(subject.valid?).to be false
          expect(subject.attribute_errors).to include('Validade (MM/AA) não é válido')
        end
      end
    end
  end
end
