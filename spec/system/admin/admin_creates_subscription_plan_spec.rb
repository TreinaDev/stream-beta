require 'rails_helper'

describe 'Administrator creates new subscription plan' do
  it 'successfully' do
    admin = create(:user, :admin)
    request = { title: 'Plano Padrão', value: '50.0' }.to_json
    response = { subscription_plan_token: '0YDlXnLGnS' }.to_json
    fake_response = instance_double(Faraday::Response, status: 201, body: response)
    header = { 'Content-Type' => 'application/json',
               'company_token' => Rails.configuration.api_pagapaga[:company_token] }
    allow(Faraday).to receive(:post).with('http://localhost:4000/api/v1/subscription_plans/', request, header)
                                    .and_return(fake_response)

    login_as admin, scope: :user
    visit root_path
    click_link 'Planos'
    click_link 'Novo Plano'
    within 'form' do
      fill_in 'Título', with: 'Plano Padrão'
      fill_in 'Descrição', with: 'Esse plano é o plano padrão'
      fill_in 'Valor padrão', with: '50'
      click_button 'Criar Plano'
    end

    subscription_plan = SubscriptionPlan.last
    expect(current_path).to eq(subscription_plan_path(subscription_plan))
    expect(subscription_plan.token).to eq('0YDlXnLGnS')
    expect(page).to have_css('div', text: 'Plano criado com sucesso!')
    expect(page).to have_content('Plano Padrão')
    expect(page).to have_content('Esse plano é o plano padrão')
    expect(page).to have_content('R$ 50,00')
  end

  it 'fails due to empty fields' do
    admin = create(:user, :admin)
    request = { title: '', value: nil }.to_json
    response = { subscription_plan_token: '' }.to_json
    fake_response = instance_double(Faraday::Response, status: 201, body: response)
    header = { 'Content-Type' => 'application/json',
               'company_token' => Rails.configuration.api_pagapaga[:company_token] }
    allow(Faraday).to receive(:post).with('http://localhost:4000/api/v1/subscription_plans/', request, header)
                                    .and_return(fake_response)

    login_as admin, scope: :user
    visit root_path
    click_link 'Planos'
    click_link 'Novo Plano'
    within 'form' do
      click_button 'Criar Plano'
    end

    expect(current_path).to eq(subscription_plans_path)
    expect(page).to have_content('Título não pode ficar em branco')
    expect(page).to have_content('Descrição não pode ficar em branco')
    expect(page).to have_content('Valor padrão não pode ficar em branco')
  end
end
