require 'rails_helper'

describe 'User cancel user subscription plan' do
  it 'successfully' do
    user = create(:user, email: 'paulo@gmail.com')
    create(:user_profile, user: user)
    plan = create(:subscription_plan, title: 'Plano legal')
    plan1 = create(:subscription_plan, title: 'Plano melhor')
    create(:user_subscription_plan, subscription_plan: plan, user: user, status: :approved, enrollment: :canceled)
    create(:user_subscription_plan, subscription_plan: plan1, user: user, status: :approved)

    login_as user, scope: :user
    visit root_path
    click_link 'Área do Assinante'
    click_link 'Minhas Assinaturas'
    click_link 'Plano legal'
    click_link 'Cancelar assinatura'

    expect(current_path).to eq(user_my_subscription_plans_path)
    expect(page).to have_content('Assinatura cancelada com sucesso!')
    expect(page).to have_content('Assinaturas canceladas')
  end
end
