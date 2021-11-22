require 'rails_helper'

describe 'Admin links playlist to subscription plan' do
  it 'successfully' do
    admin = create(:user, :admin)
    plan = create(:subscription_plan, :playlist, title: 'Jogos FPS')
    create(:playlist, title: 'Dicas de BF')

    login_as admin, scope: :user
    visit root_path
    click_link 'Planos'
    click_link 'Jogos FPS'
    click_link 'Playlists'
    click_link 'Associar Playlist'
    select 'Dicas de BF', from: 'Playlist'
    click_button 'Criar Associação de Playlist'

    expect(current_path).to eq(subscription_plan_subscription_plan_playlists_path(plan))
    expect(page).to have_css('div', text: 'Playlist associada com sucesso!')
    expect(page).to have_content('Dicas de BF')
  end

  it 'but there are no playlists available' do
    admin = create(:user, :admin)
    plan = create(:subscription_plan, :playlist, title: 'Jogos FPS')
    create(:playlist, title: 'Dicas de BF')

    login_as admin, scope: :user
    visit root_path
    click_link 'Planos'
    click_link 'Jogos FPS'
    click_link 'Playlists'
    click_link 'Associar Playlist'
    select 'Dicas de BF', from: 'Playlist'
    click_button 'Criar Associação de Playlist'
    click_link 'Associar Playlist'

    expect(current_path).to eq(subscription_plan_subscription_plan_playlists_path(plan))
    expect(page).to have_css('div', text: 'Não há playlists disponíveis para associar a esse plano')
    expect(page).to have_content('Dicas de BF')
  end

  it "and there aren't any playlists associated yet" do
    admin = create(:user, :admin)
    plan = create(:subscription_plan, :playlist, title: 'Jogos FPS')

    login_as admin, scope: :user
    visit root_path
    click_link 'Planos'
    click_link 'Jogos FPS'
    click_link 'Playlists'

    expect(current_path).to eq(subscription_plan_subscription_plan_playlists_path(plan))
    expect(page).to have_content('Ainda não há playlists associadas a esse plano')
  end

  it 'and removes it afterwards' do
    admin = create(:user, :admin)
    plan = create(:subscription_plan, :playlist, title: 'Jogos FPS')
    create(:playlist, title: 'Dicas de BF')

    login_as admin, scope: :user
    visit root_path
    click_link 'Planos'
    click_link 'Jogos FPS'
    click_link 'Playlists'
    click_link 'Associar Playlist'
    select 'Dicas de BF', from: 'Playlist'
    click_button 'Criar Associação de Playlist'
    find('tr[playlist-id="1"]').click_button('Remover')

    expect(current_path).to eq(subscription_plan_subscription_plan_playlists_path(plan))
    expect(page).to have_css('div', text: 'Associação removida com sucesso!')
    expect(page).to have_content('Ainda não há playlists associadas a esse plano')
  end

  it "but can't access it due to wrong plan type" do
    admin = create(:user, :admin)
    plan = create(:subscription_plan, :streamer, title: 'Canal do BF')

    login_as admin, scope: :user
    visit new_subscription_plan_subscription_plan_playlist_path(plan)

    expect(current_path).to eq(subscription_plan_path(plan))
    expect(page).to have_css('div', text: 'Tipo do plano não permite essa operação!')
  end
end
