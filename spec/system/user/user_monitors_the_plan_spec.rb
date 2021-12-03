require 'rails_helper'

describe 'User monitors the plan' do
  it 'cancel plan successfully' do
    user = create(:user)
    create(:user_profile, user: user)
    plan = create(:subscription_plan, title: 'Plano legal')
    payment_method = create(:payment_method, user: user)
    create(:user_subscription_plan, payment_method_token: payment_method.token,
                                    product_token: plan.token, user: user, status: :approved,
                                    enrollment: :active, subscription_plan: plan)

    login_as user, scope: :user
    visit root_path
    click_link 'Área do Assinante'
    click_link 'Minhas Assinaturas'
    click_link 'Plano legal'
    click_link 'Cancelar assinatura'

    expect(page).to have_content('Assinatura cancelada com sucesso!')
    subscription = user.user_subscription_plans.find_by(subscription_plan: plan)
    expect(subscription).to be_canceled
    expect(current_path).to eq(user_my_subscription_plans_path)
  end

  it 'reactive plan successfully' do
    user = create(:user)
    create(:user_profile, user: user)
    plan = create(:subscription_plan, title: 'Plano legal')
    payment_method = create(:payment_method, user: user)
    create(:user_subscription_plan, payment_method_token: payment_method.token,
                                    product_token: plan.token, user: user, status: :approved,
                                    enrollment: :canceled, subscription_plan: plan)

    login_as user, scope: :user
    visit root_path
    click_link 'Área do Assinante'
    click_link 'Minhas Assinaturas'
    click_link 'Plano legal'
    click_link 'Reativar assinatura'

    expect(page).to have_content('Assinatura reativada com sucesso!')
    subscription = user.user_subscription_plans.find_by(subscription_plan: plan)
    expect(subscription).to be_active
    expect(current_path).to eq(user_my_subscription_plans_path)
  end
end
