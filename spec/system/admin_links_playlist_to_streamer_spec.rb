require 'rails_helper'

describe 'admin links playlist to streamer' do
  it 'successfully' do
    admin = create(:user, :admin)
    streamer = create(:streamer, name: 'Fulaninho')

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
    select 'Fulaninho', from: 'Streamer'
    click_button 'Associar Streamer'

    expect(current_path).to eq(playlist_path(Playlist.last))
    expect(page).to have_css('div', text: 'Streamer associado com sucesso!')
    expect(page).to have_content('Título: As melhores jogadas')
    expect(page).to have_content('Streamer: Fulaninho')
    expect(page).to have_content('Descrição: Playlist com as melhores jogadas dos streamers participantes')
  end
end
