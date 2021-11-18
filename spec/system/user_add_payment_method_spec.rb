require 'rails_helper'

describe 'User add payment method' do
  context 'successfully' do
    it 'pix with random key' do
      user = create(:user)
      allow_any_instance_of(PaymentMethodsController)
        .to receive(:send_payment_method_to_pagamantos_beta).and_return('0123456789')

      login_as user, scoper: :user
      visit root_path
      click_on 'Cadastrar método de pagamento'
      select 'Pix'
      select 'Chave Aleatória'
      fill_in 'Chave', with: '32caracters'
      fill_in 'Código do banco', with: '42'
      click_on 'Enviar'

      expect(page).to have_content('Método de pagamento adicionado com sucesso')
      expect(current_path).to eq(payment_method_path(user.payment_method))
    end
  end
end
