require 'rails_helper'

describe 'Administrator cancels subscription plan' do
  it 'successfully' do
    admin = create(:user, :admin)
    subscription_plan = create(:subscription_plan, title: 'Plano de teste')
    subscription_plan_value = create(:subscription_plan_value, subscription_plan: subscription_plan)

    login_as admin, scope: :user
    visit root_path
    click_link 'Planos'
    click_link subscription_plan.title
    click_link 'Inativar plano'

    expect(current_path).to eq(subscription_plan_path(subscription_plan.id))
    expect(page).to have_content('Plano inativado com sucesso!')
  end
end

