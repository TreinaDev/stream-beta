require 'rails_helper'

describe 'User pays for recurrent plans' do
  it 'successfully if exactly one month passed' do
    user = create(:user, email: 'mateus@campos.com', password: '123456')
    create(:user_profile, user: user)
    plan = create(:subscription_plan, title: 'Plano legal')
    payment_method = create(:payment_method, user: user)

    create(:user_subscription_plan, payment_method_token: payment_method.token,
                                    product_token: plan.token, user: user, status: :pending,
                                    enrollment: :active, subscription_plan: plan, status_date: 1.month.ago.to_date)
    user_subscription_plan = { subscription_product_payment: { payment_method_token: payment_method.token,
                                                               product_token: plan.token } }
    fake_response = { payment_status: 'approved', receipt_token: 'S5sqQ4KPRD' }
    allow(ApiPagapaga).to receive(:post).with('subscription_product_payments', user_subscription_plan.to_json)
                                        .and_return(fake_response)

    visit root_path
    click_link 'Entrar'
    fill_in 'Email', with: 'mateus@campos.com'
    fill_in 'Senha', with: '123456'
    click_button 'Entrar'

    subscription = user.user_subscription_plans.find_by(subscription_plan: plan)
    expect(page).to have_css('div', text: 'Login efetuado com sucesso!')
    expect(current_path).to eq(root_path)
    expect(subscription).to be_active
    expect(subscription).to be_approved
    expect(user.subscription_plans.count).to eq 1
  end

  it 'successfully if more than one month passed' do
    user = create(:user, email: 'mateus@campos.com', password: '123456')
    create(:user_profile, user: user)
    plan = create(:subscription_plan, title: 'Plano legal')
    payment_method = create(:payment_method, user: user)

    create(:user_subscription_plan, payment_method_token: payment_method.token,
                                    product_token: plan.token, user: user, status: :pending,
                                    enrollment: :active, subscription_plan: plan, status_date: 32.days.ago.to_date)
    user_subscription_plan = { subscription_product_payment: { payment_method_token: payment_method.token,
                                                               product_token: plan.token } }
    fake_response = { payment_status: 'approved', receipt_token: 'S5sqQ4KPRD' }
    allow(ApiPagapaga).to receive(:post).with('subscription_product_payments', user_subscription_plan.to_json)
                                        .and_return(fake_response)

    visit root_path
    click_link 'Entrar'
    fill_in 'Email', with: 'mateus@campos.com'
    fill_in 'Senha', with: '123456'
    click_button 'Entrar'

    subscription = user.user_subscription_plans.find_by(subscription_plan: plan)
    expect(page).to have_css('div', text: 'Login efetuado com sucesso!')
    expect(current_path).to eq(root_path)
    expect(subscription).to be_active
    expect(subscription).to be_approved
    expect(user.subscription_plans.count).to eq 1
  end

  it 'cannot if only 28 days have passed from the subscription date' do
    user = create(:user, email: 'mateus@campos.com', password: '123456')
    create(:user_profile, user: user)
    plan = create(:subscription_plan, title: 'Plano legal')
    payment_method = create(:payment_method, user: user)

    create(:user_subscription_plan, payment_method_token: payment_method.token,
                                    product_token: plan.token, user: user, status: :pending,
                                    enrollment: :active, subscription_plan: plan, status_date: 27.days.ago.to_date)
    user_subscription_plan = { subscription_product_payment: { payment_method_token: payment_method.token,
                                                               product_token: plan.token } }
    fake_response = { payment_status: 'approved', receipt_token: 'S5sqQ4KPRD' }
    allow(ApiPagapaga).to receive(:post).with('subscription_product_payments', user_subscription_plan.to_json)
                                        .and_return(fake_response)

    visit root_path
    click_link 'Entrar'
    fill_in 'Email', with: 'mateus@campos.com'
    fill_in 'Senha', with: '123456'
    click_button 'Entrar'

    subscription = user.user_subscription_plans.find_by(subscription_plan: plan)
    expect(page).to have_css('div', text: 'Login efetuado com sucesso!')
    expect(current_path).to eq(root_path)
    expect(subscription).to be_active
    expect(subscription).to be_pending
    expect(user.subscription_plans.count).to eq 1
  end
end
