require 'rails_helper'

describe 'Administrator creates playlist' do
  it 'successfully without streamer' do
    admin = create(:user, :admin)
    create(:streamer, name: 'Fulaninho')

    login_as admin, scope: :user
    visit root_path
    click_link 'Playlists'
    click_link 'Nova Playlist'
    within 'form' do
      fill_in 'Título', with: 'As melhores jogadas'
      fill_in 'Descrição', with: 'Playlist com as melhores jogadas dos streamers participantes'
      attach_file('playlist[playlist_cover]', 'spec/fixtures/files/avatar_placeholder.png')
      click_button 'Criar Playlist'
    end

    expect(current_path).to eq(playlist_path(Playlist.last))
    expect(page).to have_css('div', text: 'Playlist criada com sucesso!')
    expect(page).to have_content('Título: As melhores jogadas')
    expect(page).to have_content('Descrição: Playlist com as melhores jogadas dos streamers participantes')
    expect(page).not_to have_content('Streamer: Fulaninho')
  end

  it 'successfully with one out of two streamers' do
    admin = create(:user, :admin)
    create(:streamer, name: 'Fulaninho')
    create(:streamer, name: 'Sicraninho')

    login_as admin, scope: :user
    visit root_path
    click_link 'Playlists'
    click_link 'Nova Playlist'
    within 'form' do
      fill_in 'Título', with: 'As melhores jogadas'
      fill_in 'Descrição', with: 'Playlist com as melhores jogadas dos streamers participantes'
      attach_file('playlist[playlist_cover]', 'spec/fixtures/files/avatar_placeholder.png')
      check 'Fulaninho'
      click_button 'Criar Playlist'
    end

    expect(current_path).to eq(playlist_path(Playlist.last))
    expect(page).to have_css('div', text: 'Playlist criada com sucesso!')
    expect(page).to have_content('Título: As melhores jogadas')
    expect(page).to have_content('Descrição: Playlist com as melhores jogadas dos streamers participantes')
    expect(page).to have_content('Streamer: Fulaninho')
    expect(page).not_to have_content('Streamer: Sicraninho')
  end

  it 'successfully with two out of three streamers' do
    admin = create(:user, :admin)
    create(:streamer, name: 'Fulaninho')
    create(:streamer, name: 'Sicraninho')
    create(:streamer, name: 'Beltraninho')

    login_as admin, scope: :user
    visit root_path
    click_link 'Playlists'
    click_link 'Nova Playlist'
    within 'form' do
      fill_in 'Título', with: 'As melhores jogadas'
      fill_in 'Descrição', with: 'Playlist com as melhores jogadas dos streamers participantes'
      attach_file('playlist[playlist_cover]', 'spec/fixtures/files/avatar_placeholder.png')
      check 'Fulaninho'
      check 'Sicraninho'
      click_button 'Criar Playlist'
    end

    expect(current_path).to eq(playlist_path(Playlist.last))
    expect(page).to have_css('div', text: 'Playlist criada com sucesso!')
    expect(page).to have_content('Título: As melhores jogadas')
    expect(page).to have_content('Descrição: Playlist com as melhores jogadas dos streamers participantes')
    expect(page).to have_content('Streamer: Fulaninho')
    expect(page).to have_content('Streamer: Sicraninho')
    expect(page).not_to have_content('Streamer: Beltraninho')
  end

  it 'but fails due to missing fields' do
    admin = create(:user, :admin)

    login_as admin, scope: :user
    visit root_path
    click_link 'Playlists'
    click_link 'Nova Playlist'
    within 'form' do
      click_button 'Criar Playlist'
    end

    expect(current_path).to eq(playlists_path)
    expect(page).to have_content('Título não pode ficar em branco')
    expect(page).to have_content('Descrição não pode ficar em branco')
    expect(page).to have_content('Capa da playlist não pode ficar em branco')
  end
end
