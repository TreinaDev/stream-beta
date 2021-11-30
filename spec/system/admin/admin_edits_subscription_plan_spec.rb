require 'rails_helper'

describe 'Administrator inactives dinamic prices' do
  it 'successfully' do
    admin = create(:user, :admin)
    subscription_plan = create(:subscription_plan, title: 'Plano de teste')
    create(:subscription_plan_value, subscription_plan: subscription_plan)

    login_as admin, scope: :user
    visit root_path
    click_link 'Planos'
    click_link subscription_plan.title
    click_link 'Editar plano'

    within 'form' do
      fill_in 'Título', with: 'Título editado'
      click_on 'Atualizar'
    end

    expect(current_path).to eq(subscription_plan_path(subscription_plan.id))
    expect(page).to have_content('Plano atualizado com sucesso!')
    expect(page).to have_content('Título: Título editado')
  end
end
