require 'rails_helper'

describe 'Admin removes video from playlist' do
  it 'successfully' do
    admin = create(:user, :admin)
    video = create(:video, title: 'Video', video_url: 'https://vimeo.com/123456789')
    playlist = create(:playlist, title: 'Playlist de jogos', videos: [video])

    login_as admin, scope: :user
    visit root_path

    click_link 'Playlists'
    click_link 'Playlist de jogos'
    click_link 'Editar playlist'
    within 'form' do
      uncheck 'Video'
      click_button 'Atualizar Playlist'
    end

    expect(current_path).to eq(playlist_path(playlist.id))
    expect(page).to have_content('Título: Playlist de jogos')
  end
end
