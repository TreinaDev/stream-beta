require 'rails_helper'

describe 'User search' do
  describe 'streamers' do
    context 'successfully' do
      it 'with 2 streamers' do
        user = create(:user)
        create(:user_profile, user: user)
        create(:streamer, name: 'joaozinho')
        create(:streamer, name: 'maria')

        login_as user, scope: :user
        visit root_path
        click_on 'Streamers'
        fill_in 'Busca:', with: 'maria'
        click_button 'Pesquisar'

        expect(current_path).to eq(search_streamers_path)
        expect(page).to have_content('maria')
        expect(page).to have_content('Pesquisa de Streamers')
        expect(page).not_to have_content('joaozinho')
      end
      it 'with nothing' do
        user = create(:user)
        create(:user_profile, user: user)

        login_as user, scope: :user
        visit root_path
        click_on 'Streamers'
        fill_in 'Busca:', with: 'maria'
        click_button 'Pesquisar'

        expect(current_path).to eq(search_streamers_path)
        expect(page).to have_content('Pesquisa de Streamers')
        expect(page).to have_content('Nenhum streamer encontrado')
      end
    end
  end
  describe 'playlists' do
    context 'successfully' do
      context 'by title' do
        it 'with to 2 playlists' do
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
          expect(page).to have_content('Pesquisa de Playlists')
          expect(page).not_to have_content('Vídeos caretas')
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
        expect(page).to have_content('Pesquisa de Playlists')
        expect(page).to have_content('Nenhuma playlist encontrada')
      end
    end
  end
end
