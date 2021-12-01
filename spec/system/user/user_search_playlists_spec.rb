require 'rails_helper'

describe 'playlists' do
  context 'successfully' do
    context 'by title' do
      it 'with 2 playlists' do
        user = create(:user)
        create(:user_profile, user: user)
        create(:playlist, title: 'Streamers mais engraçados')
        create(:playlist, title: 'Vídeos caretas')

        login_as user, scope: :user
        visit root_path
        click_on 'Playlists'
        fill_in 'Busca:', with: 'engraçados'
        click_button 'Pesquisar'

        expect(current_path).to eq(search_playlists_path)
        expect(page).to have_content('Streamers mais engraçados')
        expect(page).to have_content('Playlists')
        expect(page).not_to have_content('Vídeos caretas')
      end
    end
    context 'by description' do
      it 'with to 2 playlists' do
        user = create(:user)
        create(:user_profile, user: user)
        create(:playlist, description: 'Playlist com os vídeos mais engraçados de todo o vimeo')
        create(:playlist, description: 'Playlist chata com videos chatos')

        login_as user, scope: :user
        visit root_path
        click_on 'Playlists'
        fill_in 'Busca:', with: 'engraçados '
        click_button 'Pesquisar'

        expect(current_path).to eq(search_playlists_path)
        expect(page).to have_content('Playlist com os vídeos mais engraçados de todo o vimeo')
        expect(page).to have_content('Playlists')
        expect(page).not_to have_content('Playlist chata com videos chatos')
      end
    end
    it 'with nothing' do
      user = create(:user)
      create(:user_profile, user: user)

      login_as user, scope: :user
      visit root_path
      click_on 'Playlists'
      fill_in 'Busca:', with: ' '
      click_button 'Pesquisar'

      expect(current_path).to eq(search_playlists_path)
      expect(page).to have_content('Playlists')
      expect(page).to have_content('Nenhuma playlist encontrada')
    end
  end
end
