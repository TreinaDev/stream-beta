require 'rails_helper'

describe 'User add payment method' do
  context 'Pix' do
    it 'successfully' do
      user = create(:user)
      create(:user_profile, user: user)
      allow_any_instance_of(PaymentMethod).to receive(:generate_new_token).and_return('abcABC1234')

      login_as user, scope: :user
      visit root_path
      click_link 'Cadastrar método de pagamento'
      within 'form' do
        select 'Pix', from: 'Tipo'
        click_button 'Enviar'
      end

      expect(current_path).to eq payment_method_path(user.payment_methods.first)
      expect(page).to have_css('div', text: 'Método de pagamento adicionado com sucesso!')
    end
  end

  context 'Credit card' do
    it 'successfully' do
      user = create(:user)
      create(:user_profile, user: user)
      allow_any_instance_of(PaymentMethod).to receive(:generate_new_token).and_return('abcABC1234')

      login_as user, scope: :user
      visit root_path
      click_link 'Cadastrar método de pagamento'
      within 'form' do
        select 'Cartão de Crédito', from: 'Tipo'
        fill_in 'Número do Cartão', with: '01234567890123456789'
        fill_in 'Código de Segurança (CVV)', with: '042'
        fill_in 'Validade (MM/AA)', with: '10/22'
        click_button 'Enviar'
      end

      expect(current_path).to eq payment_method_path(user.payment_methods.first)
      expect(page).to have_css('div', text: 'Método de pagamento adicionado com sucesso!')
    end

    it 'failure add method' do
      user = create(:user)
      create(:user_profile, user: user)
      allow_any_instance_of(PaymentMethod).to receive(:generate_new_token).and_return('')

      login_as user, scope: :user
      visit root_path
      click_link 'Cadastrar método de pagamento'
      within 'form' do
        select 'Cartão de Crédito', from: 'Tipo'
        fill_in 'Número do Cartão', with: ''
        fill_in 'Código de Segurança (CVV)', with: ''
        fill_in 'Validade (MM/AA)', with: ''
        click_button 'Enviar'
      end

      expect(page).not_to have_content('Método de pagamento adicionado com sucesso')
      expect(page).to have_content('Cadastro de Método de Pagamento')
      expect(page).to have_content('Método de Pagamento inválido')
    end
  end

  context 'Boleto' do
    it 'successfully' do
      user = create(:user)
      create(:user_profile, user: user)
      allow_any_instance_of(PaymentMethod).to receive(:generate_new_token).and_return('abcABC1234')

      login_as user, scope: :user
      visit root_path
      click_link 'Cadastrar método de pagamento'
      within 'form' do
        select 'Boleto', from: 'Tipo'
        click_button 'Enviar'
      end

      expect(current_path).to eq payment_method_path(user.payment_methods.first)
      expect(page).to have_css('div', text: 'Método de pagamento adicionado com sucesso!')
    end

    it 'failure add method' do
      user = create(:user)
      create(:user_profile, user: user)
      allow_any_instance_of(PaymentMethod).to receive(:generate_new_token).and_return('')

      login_as user, scope: :user
      visit root_path
      click_link 'Cadastrar método de pagamento'
      within 'form' do
        select 'Boleto', from: 'Tipo'
        click_button 'Enviar'
      end

      expect(page).not_to have_content('Método de pagamento adicionado com sucesso')
      expect(page).to have_content('Cadastro de Método de Pagamento')
      expect(page).to have_content('Método de Pagamento inválido')
    end
  end
end
