require 'rails_helper'

describe 'Admin removes video from playlist' do
  it 'successfully' do
    admin = create(:user, :admin)
    outro_video = create(:video, title: 'Outro video', video_url: '987654321')
    video = create(:video, title: 'Videozinho', video_url: '123456789')
    playlist = create(:playlist, title: 'Playlist de jogos', video_ids: [video.id, outro_video.id])

    login_as admin, scope: :user
    visit root_path

    click_link 'Playlists'
    click_link 'Playlist de jogos'
    click_link 'Editar playlist'
    within 'form' do
      uncheck 'Videozinho'
      click_button 'Atualizar Playlist'
    end

    expect(current_path).to eq(playlist_path(playlist.id))
    expect(page).to have_content('Título: Playlist de jogos')
    expect(page).to have_content('Outro video')
    expect(page).not_to have_content('Videozinho')
    expect(page).not_to have_link('123456789')
  end
end
