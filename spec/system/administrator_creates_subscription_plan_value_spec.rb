require 'rails_helper'

describe 'Administrator creates subscription plan value' do
  it 'successfully' do
    admin = create(:user, :admin)
    subscription_plan = create(:subscription_plan, title: 'Plano de teste')

    login_as admin, scope: :user
    visit root_path
    click_link 'Planos'
    click_link subscription_plan.title
    click_link 'Preços dinâmicos'
    click_link 'Incluir novo preço'
    within 'form' do
      fill_in 'Data inicial', with: Date.current
      fill_in 'Data final', with: 15.days.from_now
      fill_in 'Valor', with: '99.90'
      click_button 'Criar Preço dinâmico'
    end

    expect(current_path).to eq(subscription_plan_subscription_plan_values_path(subscription_plan))
    expect(page).to have_content('Plano de teste')
    expect(page).to have_content(I18n.l(15.days.from_now.to_date))
    expect(page).to have_content('R$ 99,90')
  end

  it 'fails due to empty fields' do
    admin = create(:user, :admin)
    subscription_plan = create(:subscription_plan, title: 'Plano de teste')

    login_as admin, scope: :user
    visit root_path
    click_link 'Planos'
    click_link subscription_plan.title
    click_link 'Preços dinâmicos'
    click_link 'Incluir novo preço'
    within 'form' do
      click_button 'Criar Preço dinâmico'
    end

    expect(current_path).to eq(subscription_plan_subscription_plan_values_path(subscription_plan))
    expect(page).to have_content('Data inicial não pode ficar em branco')
    expect(page).to have_content('Data final não pode ficar em branco')
    expect(page).to have_content('Valor não pode ficar em branco')
  end

  it 'and can only see values for the current plan' do
    admin = create(:user, :admin)
    first_subscription_plan = create(:subscription_plan, title: 'Primeiro Plano')
    second_subscription_plan = create(:subscription_plan, title: 'Segundo Plano')
    create(:subscription_plan_value, subscription_plan: first_subscription_plan)

    login_as admin, scope: :user
    visit root_path
    click_link 'Planos'
    click_link 'Segundo Plano'
    click_link 'Preços dinâmicos'

    expect(current_path).to eq subscription_plan_subscription_plan_values_path(second_subscription_plan)
    expect(page).to have_content('Ainda não há preços dinâmicos cadastrados para esse plano')
  end
end
