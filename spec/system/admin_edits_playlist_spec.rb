require 'rails_helper'

describe 'Administrator edits playlist' do
  context 'successfully' do
    it 'changes playlist attributes' do
      admin = create(:user, :admin)
      playlist = create(:playlist, title: 'Playlistizinha')

      login_as admin, scope: :user
      visit root_path
      click_link 'Playlists'
      click_link 'Playlistizinha'
      click_link 'Editar playlist'
      within 'form' do
        fill_in 'Título', with: 'Playliste'
        fill_in 'Descrição', with: 'Descrição da Playliste'
        click_button 'Atualizar Playlist'
      end

      expect(current_path).to eq(playlist_path(playlist.id))
      expect(page).to have_content('Título: Playliste')
      expect(page).to have_content('Descrição: Descrição da Playliste')
    end

    it 'changes playlist status' do
      admin = create(:user, :admin)
      playlist = create(:playlist, title: 'Playlistizinha')

      login_as admin, scope: :user
      visit root_path
      click_link 'Playlists'
      click_link 'Playlistizinha'
      click_link 'Editar playlist'
      click_link 'Desativar Playlist'

      expect(current_path).to eq(playlist_path(playlist.id))
      expect(page).to have_content('Playlist desativada com successo!')
      expect(page).to have_content('Status: Desativada')
      expect(page).to have_content('Título: Playlistizinha')
    end
  end
end
