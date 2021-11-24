require 'rails_helper'

describe 'Administrator creates new subscription plan' do
  it 'successfully' do
    admin = create(:user, :admin)

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

    expect(current_path).to eq(subscription_plan_path(SubscriptionPlan.last))
    expect(page).to have_css('div', text: 'Plano criado com sucesso!')
    expect(page).to have_content('Plano Padrão')
    expect(page).to have_content('Esse plano é o plano padrão')
    expect(page).to have_content('R$ 50,00')
  end

  it 'fails due to empty fields' do
    admin = create(:user, :admin)

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
