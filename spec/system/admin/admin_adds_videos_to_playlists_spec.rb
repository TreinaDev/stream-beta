require 'rails_helper'

describe 'Admin adds videos to playlist' do
  it 'successfully' do
    admin = create(:user, :admin)
    video = create(:video, title: 'Video', video_url: '123456789')
    create(:video, title: 'Video errado', video_url: '987654321')
    playlist = create(:playlist, title: 'Playlist de jogos')

    login_as admin, scope: :user
    visit root_path

    click_link 'Playlists'
    click_link 'Playlist de jogos'
    click_link 'Editar playlist'
    within 'form' do
      check 'Video'
      click_button 'Atualizar Playlist'
    end

    expect(current_path).to eq(playlist_path(playlist.id))
    expect(page).to have_content('Playlist de jogos')
    expect(page).to have_content('Video')
    expect(page).not_to have_content('Video errado')
    expect(page).to have_link('Video', href: video_path(video))
  end
end
