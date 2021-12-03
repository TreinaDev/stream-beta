require 'rails_helper'

describe 'Admin cancels subscription plan value' do
  it 'successfully' do
    admin = create(:user, :admin)
    first_subscription_plan = create(:subscription_plan, title: 'Primeiro Plano')
    create(:subscription_plan_value, subscription_plan: first_subscription_plan)

    login_as admin, scope: :user
    visit root_path
    click_link 'Planos'
    click_link 'Primeiro Plano'
    click_link 'Preços dinâmicos'
    click_link 'Desativar preço'

    expect(current_path).to eq(subscription_plan_subscription_plan_values_path(first_subscription_plan))
    expect(page).to have_content('Ainda não há preços dinâmicos cadastrados para esse plano')
    expect(page).to have_content('Preço dinâmico desativado com sucesso!')
  end
end
