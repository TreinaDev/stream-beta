require 'rails_helper'

describe 'Admin links streamer to subscription plan' do
  it 'successfully' do
    admin = create(:user, :admin)
    plan = create(:subscription_plan, :streamer, title: 'Canal do BF')
    create(:streamer, name: 'Player de BF')

    login_as admin, scope: :user
    visit root_path
    click_link 'Planos'
    click_link 'Canal do BF'
    click_link 'Associar Streamer'
    select 'Player de BF', from: 'Streamer'
    click_button 'Criar Associação de Streamer'

    expect(current_path).to eq(subscription_plan_path(plan))
    expect(page).to have_css('div', text: 'Streamer associado com sucesso!')
    expect(page).to have_content('Player de BF')
  end

  it 'and edits it successfully' do
    admin = create(:user, :admin)
    plan = create(:subscription_plan, :streamer, title: 'Canal do BF')
    streamer = create(:streamer, name: 'Player de BF')
    plan.streamer = streamer
    create(:streamer, name: 'Profissional de BF')

    login_as admin, scope: :user
    visit root_path
    click_link 'Planos'
    click_link 'Canal do BF'
    click_link 'Editar Streamer'
    select 'Profissional de BF', from: 'Streamer'
    click_button 'Atualizar Associação de Streamer'

    expect(current_path).to eq(subscription_plan_path(plan))
    expect(page).to have_css('div', text: 'Streamer associado com sucesso!')
    expect(page).to have_content('Profissional de BF')
  end

  it "but can't access it due to wrong plan type" do
    admin = create(:user, :admin)
    plan = create(:subscription_plan, :playlist, title: 'Canal do BF')

    login_as admin, scope: :user
    visit new_subscription_plan_subscription_plan_streamer_path(plan)

    expect(current_path).to eq(subscription_plan_path(plan))
    expect(page).to have_css('div', text: 'Tipo do plano não permite essa operação!')
  end
end
