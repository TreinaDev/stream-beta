require 'rails_helper'

describe 'User add payment method' do
  context 'Pix' do
    context 'successfully' do
      it 'Random key' do
        user = create(:user)
        allow_any_instance_of(PaymentMethodsController)
          .to receive(:send_payment_method_to_pagamantos_beta).and_return('0123456789')

        login_as user, scoper: :user
        visit root_path
        click_on 'Cadastrar método de pagamento'
        select 'Pix'
        select 'Chave Aleatória'
        fill_in 'Chave', with: '32caracters'
        fill_in 'Código do banco', with: '042'
        click_on 'Enviar'

        expect(page).to have_content('Método de pagamento adicionado com sucesso')
        expect(current_path).to eq(payment_method_path(user.payment_method))
      end

      it 'Telephone' do
        user = create(:user)
        allow_any_instance_of(PaymentMethodsController)
          .to receive(:send_payment_method_to_pagamantos_beta).and_return('0123456789')

        login_as user, scoper: :user
        visit root_path
        click_on 'Cadastrar método de pagamento'
        select 'Pix'
        select 'Telefone'
        fill_in 'Chave', with: 11_999_999_999
        fill_in 'Código do banco', with: '042'
        click_on 'Enviar'

        expect(page).to have_content('Método de pagamento adicionado com sucesso')
        expect(current_path).to eq(payment_method_path(user.payment_method))
      end

      it 'Email' do
        user = create(:user, email: 'user@email.com')
        allow_any_instance_of(PaymentMethodsController)
          .to receive(:send_payment_method_to_pagamantos_beta).and_return('0123456789')

        login_as user, scoper: :user
        visit root_path
        click_on 'Cadastrar método de pagamento'
        select 'Pix'
        select 'Email'
        fill_in 'Chave', with: 'user@email.com'
        fill_in 'Código do banco', with: '042'
        click_on 'Enviar'

        expect(page).to have_content('Método de pagamento adicionado com sucesso')
        expect(current_path).to eq(payment_method_path(user.payment_method))
      end

      it 'CPF' do
        user = create(:user, email: 'user@email.com')
        allow_any_instance_of(PaymentMethodsController)
          .to receive(:send_payment_method_to_pagamantos_beta).and_return('0123456789')

        login_as user, scoper: :user
        visit root_path
        click_on 'Cadastrar método de pagamento'
        select 'Pix'
        select 'CPF'
        fill_in 'Chave', with: '08091298271'
        fill_in 'Código do banco', with: '042'
        click_on 'Enviar'

        expect(page).to have_content('Método de pagamento adicionado com sucesso')
        expect(current_path).to eq(payment_method_path(user.payment_method))
      end

      it 'CNPJ' do
        user = create(:user, email: 'user@email.com')
        allow_any_instance_of(PaymentMethodsController)
          .to receive(:send_payment_method_to_pagamantos_beta).and_return('0123456789')

        login_as user, scoper: :user
        visit root_path
        click_on 'Cadastrar método de pagamento'
        select 'Pix'
        select 'CNPJ'
        fill_in 'Chave', with: '30525040000150'
        fill_in 'Código do banco', with: '042'
        click_on 'Enviar'

        expect(page).to have_content('Método de pagamento adicionado com sucesso')
        expect(current_path).to eq(payment_method_path(user.payment_method))
      end
    end

    it 'failure add method' do
      user = create(:user, email: 'user@email.com')
      allow_any_instance_of(PaymentMethodsController)
        .to receive(:send_payment_method_to_pagamantos_beta).and_return('error')

      login_as user, scoper: :user
      visit root_path
      click_on 'Cadastrar método de pagamento'
      select 'Pix'
      select 'CPF'
      fill_in 'Chave', with: ''
      fill_in 'Código do banco', with: ''
      click_on 'Enviar'

      expect(page).not_to have_content('Método de pagamento adicionado com sucesso')
      expect(page).to have_content('Cadastro de Método de Pagamento')
      expect(page).to have_content('Método de Pagamento inválido')
    end
  end

  context 'Credit card' do
    it 'successfully' do
      user = create(:user, email: 'user@email.com')
      allow_any_instance_of(PaymentMethodsController)
        .to receive(:send_payment_method_to_pagamantos_beta).and_return('0123456789')

      login_as user, scoper: :user
      visit root_path
      click_on 'Cadastrar método de pagamento'
      select 'Cartão de Crédito'
      fill_in 'Número da Conta', with: '20caracteres'
      fill_in 'Código do banco', with: '042'
      click_on 'Enviar'

      expect(page).to have_content('Método de pagamento adicionado com sucesso')
      expect(current_path).to eq(payment_method_path(user.payment_method))
    end

    it 'failure add method' do
      user = create(:user, email: 'user@email.com')
      allow_any_instance_of(PaymentMethodsController)
        .to receive(:send_payment_method_to_pagamantos_beta).and_return('error')

      login_as user, scoper: :user
      visit root_path
      click_on 'Cadastrar método de pagamento'
      select 'Cartão de Crédito'
      fill_in 'Número da Conta', with: ''
      fill_in 'Código do banco', with: ''
      click_on 'Enviar'

      expect(page).not_to have_content('Método de pagamento adicionado com sucesso')
      expect(page).to have_content('Cadastro de Método de Pagamento')
      expect(page).to have_content('Método de Pagamento inválido')
    end
  end

  context 'Boleto' do
    it 'successfully' do
      user = create(:user, email: 'user@email.com')
      allow_any_instance_of(PaymentMethodsController)
        .to receive(:send_payment_method_to_pagamantos_beta).and_return('0123456789')

      login_as user, scoper: :user
      visit root_path
      click_on 'Cadastrar método de pagamento'
      select 'Boleto'
      fill_in 'Número da Conta', with: '20caracteres'
      fill_in 'Número da Agência', with: '9999-9'
      fill_in 'Código do banco', with: '042'
      click_on 'Enviar'

      expect(page).to have_content('Método de pagamento adicionado com sucesso')
      expect(current_path).to eq(payment_method_path(user.payment_method))
    end

    it 'failure add method' do
      user = create(:user, email: 'user@email.com')
      allow_any_instance_of(PaymentMethodsController)
        .to receive(:send_payment_method_to_pagamantos_beta).and_return('error')

      login_as user, scoper: :user
      visit root_path
      click_on 'Cadastrar método de pagamento'
      select 'Boleto'
      fill_in 'Número da Conta', with: ''
      fill_in 'Número da Agência', with: ''
      fill_in 'Código do banco', with: ''
      click_on 'Enviar'

      expect(page).not_to have_content('Método de pagamento adicionado com sucesso')
      expect(page).to have_content('Cadastro de Método de Pagamento')
      expect(page).to have_content('Método de Pagamento inválido')
    end
  end
end
