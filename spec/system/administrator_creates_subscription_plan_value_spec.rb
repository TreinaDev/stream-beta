require 'rails_helper'

describe 'Administrator creates subscription plan value' do
  it 'successfully' do
    admin = create(:user, :admin)
    subscription_plan = create(:subscription_plan, title: 'Plano de teste')
    login_as admin, scope: :user
    visit root_path
    click_on 'Planos'
    click_on subscription_plan.title
    click_on 'Preços dinâmicos'
    click_on 'Incluir novo preço'

    fill_in 'Data inicial', with: Date.current
    fill_in 'Data final', with: 15.days.from_now
    fill_in 'Valor', with: '99.90'

    click_on 'Criar Preço dinâmico'

    expect(current_path).to eq(subscription_plan_subscription_plan_values_path(subscription_plan))
    expect(page).to have_content('Plano de teste')
    expect(page).to have_content(15.days.from_now.to_date)
    expect(page).to have_content('R$ 99,90')
  end
end
