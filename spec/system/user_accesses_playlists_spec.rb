require 'rails_helper'

describe 'User accesses playlists' do
  context 'and can access' do
    it 'index page' do
      user = create(:user)

      login_as user, scope: :user
      visit root_path
      click_link 'Playlists'

      expect(current_path).to eq(playlists_path)
      expect(page).to have_content('Playlists')
      expect(page).to have_no_content('Nova Playlist')
    end
  end

  context 'and can not access' do
    it 'new page' do
      user = create(:user)

      login_as user, scope: :user
      visit new_playlist_path

      expect(current_path).to eq(root_path)
      expect(page).to have_content('Acesso não autorizado!')
    end
  end
end
