require 'rails_helper'

describe 'User add payment method' do
  let(:header) do
    { 'Content-Type' => 'application/json', 'company_token' => Rails.configuration.api_pagapaga[:company_token] }
  end

  context 'Pix' do
    it 'successfully' do
      allow(Faraday).to receive(:post).with('http://localhost:4000/api/v1/account_holders/', any_args)
      payment_methods_response = File.read(Rails.root.join('spec/support/apis/available_payment_methods/all.json'))
      fake_response_apm = instance_double(Faraday::Response, status: 200, body: payment_methods_response)
      allow(Faraday).to receive(:get).with('http://localhost:4000/api/v1/available_payment_methods/', {}, header)
                                     .and_return(fake_response_apm)

      request = JSON.parse(File.read(Rails.root.join('spec/support/apis/user_payment_methods/pix.json')))
      response = { payment_method_token: 'BYZBrjim0W' }.to_json
      fake_response = instance_double(Faraday::Response, status: 201, body: response)
      allow(Faraday).to receive(:post).with('http://localhost:4000/api/v1/payment_methods/', request.to_json, header)
                                      .and_return(fake_response)

      user = create(:user)
      create(:user_profile, user: user, cpf: request['payment_method']['cpf'])

      login_as user, scope: :user
      visit root_path
      click_link 'Cadastrar método de pagamento'
      within 'form' do
        select 'Pix', from: 'Tipo'
        click_button 'Enviar'
      end

      payment_method = user.payment_methods.last
      expect(current_path).to eq payment_method_path(user.payment_methods.first)
      expect(payment_method.token).to eq('BYZBrjim0W')
      expect(page).to have_css('div', text: 'Método de pagamento adicionado com sucesso!')
    end
  end

  context 'Credit card' do
    it 'successfully' do
      allow(Faraday).to receive(:post).with('http://localhost:4000/api/v1/account_holders/', any_args)
      payment_methods_response = File.read(Rails.root.join('spec/support/apis/available_payment_methods/all.json'))
      fake_response_apm = instance_double(Faraday::Response, status: 200, body: payment_methods_response)
      allow(Faraday).to receive(:get).with('http://localhost:4000/api/v1/available_payment_methods/', {}, header)
                                     .and_return(fake_response_apm)

      request = JSON.parse(File.read(Rails.root.join('spec/support/apis/user_payment_methods/credit_card.json')))
      response = { payment_method_token: 'BYZBrjim0W' }.to_json
      fake_response = instance_double(Faraday::Response, status: 201, body: response)
      allow(Faraday).to receive(:post).with('http://localhost:4000/api/v1/payment_methods/', request.to_json, header)
                                      .and_return(fake_response)

      user = create(:user)
      create(:user_profile, user: user, cpf: request['payment_method']['cpf'])

      login_as user, scope: :user
      visit root_path
      click_link 'Cadastrar método de pagamento'
      within 'form' do
        select 'Cartão de Crédito', from: 'Tipo'
        fill_in 'Número do Cartão', with: '1234567890123456'
        fill_in 'Código de Segurança (CVV)', with: '123'
        fill_in 'Validade (MM/AA)', with: '10/26'
        click_button 'Enviar'
      end

      expect(current_path).to eq payment_method_path(user.payment_methods.first)
      expect(page).to have_css('div', text: 'Método de pagamento adicionado com sucesso!')
    end

    it 'failure add method' do
      allow(Faraday).to receive(:post).with('http://localhost:4000/api/v1/account_holders/', any_args)
      payment_methods_response = File.read(Rails.root.join('spec/support/apis/available_payment_methods/all.json'))
      fake_response_apm = instance_double(Faraday::Response, status: 200, body: payment_methods_response)
      allow(Faraday).to receive(:get).with('http://localhost:4000/api/v1/available_payment_methods/', {}, header)
                                     .and_return(fake_response_apm)

      request = JSON.parse(
        File.read(Rails.root.join('spec/support/apis/user_payment_methods/invalid_credit_card.json'))
      )
      response = { payment_method_token: '' }.to_json
      fake_response = instance_double(Faraday::Response, status: 201, body: response)
      allow(Faraday).to receive(:post).with('http://localhost:4000/api/v1/payment_methods/', request.to_json, header)
                                      .and_return(fake_response)

      user = create(:user)
      create(:user_profile, user: user, cpf: request['payment_method']['cpf'])

      login_as user, scope: :user
      visit root_path
      click_link 'Cadastrar método de pagamento'
      within 'form' do
        select 'Cartão de Crédito', from: 'Tipo'
        fill_in 'Operadora', with: ''
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
      allow(Faraday).to receive(:post).with('http://localhost:4000/api/v1/account_holders/', any_args)
      payment_methods_response = File.read(Rails.root.join('spec/support/apis/available_payment_methods/all.json'))
      fake_response_apm = instance_double(Faraday::Response, status: 200, body: payment_methods_response)
      allow(Faraday).to receive(:get).with('http://localhost:4000/api/v1/available_payment_methods/', {}, header)
                                     .and_return(fake_response_apm)

      request = JSON.parse(File.read(Rails.root.join('spec/support/apis/user_payment_methods/boleto.json')))
      response = { payment_method_token: 'BYZBrjim0W' }.to_json
      fake_response = instance_double(Faraday::Response, status: 201, body: response)
      allow(Faraday).to receive(:post).with('http://localhost:4000/api/v1/payment_methods/', request.to_json, header)
                                      .and_return(fake_response)

      user = create(:user)
      create(:user_profile, user: user, cpf: request['payment_method']['cpf'])

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

    it 'failure to add method' do
      allow(Faraday).to receive(:post).with('http://localhost:4000/api/v1/account_holders/', any_args)
      payment_methods_response = File.read(Rails.root.join('spec/support/apis/available_payment_methods/all.json'))
      fake_response_apm = instance_double(Faraday::Response, status: 200, body: payment_methods_response)
      allow(Faraday).to receive(:get).with('http://localhost:4000/api/v1/available_payment_methods/', {}, header)
                                     .and_return(fake_response_apm)

      request = JSON.parse(File.read(Rails.root.join('spec/support/apis/user_payment_methods/boleto.json')))
      response = {}.to_json
      fake_response = instance_double(Faraday::Response, status: 500, body: response)
      allow(Faraday).to receive(:post).with('http://localhost:4000/api/v1/payment_methods/', request.to_json, header)
                                      .and_return(fake_response)

      user = create(:user)
      create(:user_profile, user: user, cpf: request['payment_method']['cpf'])

      login_as user, scope: :user
      visit root_path
      click_link 'Cadastrar método de pagamento'
      within 'form' do
        select 'Boleto', from: 'Tipo'
        click_button 'Enviar'
      end

      expect(page).not_to have_content('Método de pagamento adicionado com sucesso')
      expect(page).to have_content('Cadastro de Método de Pagamento')
      expect(page).to have_content('Ocorreu um erro no servidor externo')
    end
  end
end
