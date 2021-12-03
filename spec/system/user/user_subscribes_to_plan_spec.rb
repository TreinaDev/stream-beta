require 'rails_helper'

describe 'User subscribes to plan' do
  let(:header) do
    { 'Content-Type' => 'application/json', 'company_token' => Rails.configuration.api_pagapaga[:company_token] }
  end

  context 'when authenticated' do
    it 'successfully with default value' do
      user = create(:user)
      create(:user_profile, user: user)
      plan = create(:subscription_plan, title: 'Plano legal')
      payment_method = create(:payment_method, user: user)

      payment_methods_response = File.read(Rails.root.join('spec/support/apis/available_payment_methods/all.json'))
      fake_response_apm = instance_double(Faraday::Response, status: 200, body: payment_methods_response)
      allow(Faraday).to receive(:get).with('http://localhost:4000/api/v1/available_payment_methods/', {}, header)
                                     .and_return(fake_response_apm)

      user_subscription_plan = { subscription_product_payment: { payment_method_token: payment_method.token,
                                                                 product_token: plan.token } }
      fake_response = { payment_status: 'approved', receipt_token: 'S5sqQ4KPRD' }
      allow(ApiPagapaga).to receive(:post).with('subscription_product_payments', user_subscription_plan.to_json)
                                          .and_return(fake_response)

      login_as user, scope: :user
      visit root_path
      click_link 'Planos'
      click_link 'Plano legal'
      click_link 'Assinar plano'
      click_button 'Criar Assinatura de Plano'

      subscription = user.user_subscription_plans.find_by(subscription_plan: plan)
      expect(current_path).to eq(subscription_plan_path(plan))
      expect(subscription).to be_approved
      expect(page).to have_css('div', text: 'Assinatura realizada com sucesso!')
      expect(page).to have_no_content('Assinar plano')
      expect(user.subscription_plans.count).to eq 1
    end

    it 'successfully with dynamic value' do
      user = create(:user)
      create(:user_profile, user: user)
      plan = create(:subscription_plan, title: 'Plano legal')
      create(:subscription_plan_value, start_date: Date.current, end_date: 3.days.from_now, value: 20,
                                       subscription_plan: plan)
      payment_method = create(:payment_method, user: user)

      payment_methods_response = File.read(Rails.root.join('spec/support/apis/available_payment_methods/all.json'))
      fake_response_apm = instance_double(Faraday::Response, status: 200, body: payment_methods_response)
      allow(Faraday).to receive(:get).with('http://localhost:4000/api/v1/available_payment_methods/', {}, header)
                                     .and_return(fake_response_apm)

      user_subscription_plan = { subscription_product_payment: { payment_method_token: payment_method.token,
                                                                 product_token: plan.token } }
      fake_response = { payment_status: 'approved', receipt_token: 'S5sqQ4KPRD' }
      allow(ApiPagapaga).to receive(:post).with('subscription_product_payments', user_subscription_plan.to_json)
                                          .and_return(fake_response)

      login_as user, scope: :user
      visit root_path
      click_link 'Planos'
      click_link 'Plano legal'
      click_link 'Assinar plano'
      click_button 'Criar Assinatura de Plano'

      subscription = user.user_subscription_plans.find_by(subscription_plan: plan)
      expect(subscription).to be_approved
      expect(current_path).to eq(subscription_plan_path(plan))
      expect(page).to have_css('div', text: 'Assinatura realizada com sucesso!')
      expect(page).to have_no_content('Assinar plano')
      expect(user.subscription_plans.count).to eq 1
    end

    it 'but fails due to payment not authorized' do
      user = create(:user)
      create(:user_profile, user: user)
      plan = create(:subscription_plan, title: 'Plano legal')
      payment_method = create(:payment_method, user: user)

      payment_methods_response = File.read(Rails.root.join('spec/support/apis/available_payment_methods/all.json'))
      fake_response_apm = instance_double(Faraday::Response, status: 200, body: payment_methods_response)
      allow(Faraday).to receive(:get).with('http://localhost:4000/api/v1/available_payment_methods/', {}, header)
                                     .and_return(fake_response_apm)

      user_subscription_plan = { subscription_product_payment: { payment_method_token: payment_method.token,
                                                                 product_token: plan.token } }
      fake_response = { payment_status: 'rejected', receipt_token: '' }
      allow(ApiPagapaga).to receive(:post).with('subscription_product_payments', user_subscription_plan.to_json)
                                          .and_return(fake_response)

      login_as user, scope: :user
      visit root_path
      click_link 'Planos'
      click_link 'Plano legal'
      click_link 'Assinar plano'
      click_button 'Criar Assinatura de Plano'

      subscription = user.user_subscription_plans.find_by(subscription_plan: plan)
      expect(subscription).to be_rejected
      expect(current_path).to eq(subscription_plan_path(plan))
      expect(page).to have_css('div', text: 'Pagamento reprovado')
      expect(page).to have_link('Assinar plano')
      expect(user.subscription_plans.count).to eq 1
    end

    it 'and the payment status is pending' do
      user = create(:user)
      create(:user_profile, user: user)
      plan = create(:subscription_plan, title: 'Plano legal')
      payment_method = create(:payment_method, user: user)

      payment_methods_response = File.read(Rails.root.join('spec/support/apis/available_payment_methods/all.json'))
      fake_response_apm = instance_double(Faraday::Response, status: 200, body: payment_methods_response)
      allow(Faraday).to receive(:get).with('http://localhost:4000/api/v1/available_payment_methods/', {}, header)
                                     .and_return(fake_response_apm)

      user_subscription_plan = { subscription_product_payment: { payment_method_token: payment_method.token,
                                                                 product_token: plan.token } }
      fake_response = { payment_status: 'pending', receipt_token: '' }
      allow(ApiPagapaga).to receive(:post).with('subscription_product_payments', user_subscription_plan.to_json)
                                          .and_return(fake_response)

      login_as user, scope: :user
      visit root_path
      click_link 'Planos'
      click_link 'Plano legal'
      click_link 'Assinar plano'
      click_button 'Criar Assinatura de Plano'

      subscription = user.user_subscription_plans.find_by(subscription_plan: plan)
      expect(subscription).to be_pending
      expect(current_path).to eq(subscription_plan_path(plan))
      expect(page).to have_css('div', text: 'Pagamento em análise')
      expect(page).to have_no_link('Assinar plano')
      expect(user.subscription_plans.count).to eq 1
    end
  end

  context 'when not authenticated' do
    it 'trying to purchase a plan will redirect to sign_in screen' do
      create(:subscription_plan, title: 'Plano legal')

      visit root_path
      click_link 'Planos'
      click_link 'Plano legal'
      click_link 'Assinar plano'

      expect(current_path).to eq(new_user_session_path)
    end
  end

  it 'successfully using the last promotion_ticket' do
    user = create(:user)
    create(:user_profile, user: user)
    ticket = create(:promotion_ticket, title: 'BETA10STREAMER', discount: 20,
                                       maximum_value_reduction: 10, maximum_uses: 1)
    plan = create(:subscription_plan, title: 'Plano legal', value: 50, promotion_ticket: ticket)
    payment_method = create(:payment_method, user: user)

    payment_methods_response = File.read(Rails.root.join('spec/support/apis/available_payment_methods/all.json'))
    fake_response_apm = instance_double(Faraday::Response, status: 200, body: payment_methods_response)
    allow(Faraday).to receive(:get).with('http://localhost:4000/api/v1/available_payment_methods/', {}, header)
                                   .and_return(fake_response_apm)

    user_subscription_plan = { subscription_product_payment: { payment_method_token: payment_method.token,
                                                               product_token: plan.token } }
    fake_response = { payment_status: 'approved', receipt_token: 'S5sqQ4KPRD' }
    allow(ApiPagapaga).to receive(:post).with('subscription_product_payments', user_subscription_plan.to_json)
                                        .and_return(fake_response)

    login_as user, scope: :user
    visit root_path
    click_link 'Planos'
    click_link 'Plano legal'
    click_link 'Assinar plano'
    click_button 'Criar Assinatura de Plano'

    subscription = user.user_subscription_plans.find_by(subscription_plan: plan)
    expect(current_path).to eq(subscription_plan_path(plan))
    expect(subscription).to be_approved
    expect(page).to have_css('div', text: 'Assinatura realizada com sucesso!')
    expect(page).to have_no_content('Assinar plano')
    expect(user.subscription_plans.count).to eq 1
    expect(PromotionTicket.last.maximum_uses).to eq 0
  end
end
