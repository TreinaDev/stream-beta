require 'rails_helper'

describe 'Administrator creates new subscription plan' do 
  it 'successfully' do
    admin = create(:user, :admin)

    login_as admin, scope: :user
    visit root_path
    click_on 'Planos'
    click_on 'Novo Plano'
    fill_in 'Título', with: 'Plano Padrão'
    fill_in 'Descrição', with: 'Esse plano é o plano padrão'
    fill_in 'Valor padrão', with: '50'
    click_on 'Criar Plano'

    expect(current_path).to eq(subscription_plan_path(SubscriptionPlan.last))
    expect(page).to have_content('Plano criado com sucesso!')
    expect(page).to have_content('Plano Padrão')
    expect(page).to have_content('Esse plano é o plano padrão')
    expect(page).to have_content('R$ 50,00')
  end
end
