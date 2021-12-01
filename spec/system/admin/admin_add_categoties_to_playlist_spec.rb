require 'rails_helper'

describe 'Administrator category to playlist ' do
  context 'create playlist' do
    context 'successfully' do
      it 'just one' do
        admin = create(:user, :admin)
        create(:streamer, name: 'Fulaninho')
        create(:video_category, title: 'Jogos')
        create(:video_category, title: 'ASMR')
        login_as admin, scope: :user
        visit root_path
        click_link 'Playlists'
        click_link 'Nova Playlist'
        within 'form' do
          fill_in 'Título', with: 'As melhores jogadas'
          fill_in 'Descrição', with: 'Playlist com as melhores jogadas dos streamers participantes'
          attach_file('playlist[playlist_cover]', 'spec/fixtures/files/avatar_placeholder.png')
          check 'Jogos'
          click_button 'Criar Playlist'
        end

        expect(current_path).to eq(playlist_path(Playlist.last))
        expect(page).to have_css('div', text: 'Playlist criada com sucesso!')
        expect(page).to have_content('Título: As melhores jogadas')
        expect(page).to have_content('Descrição: Playlist com as melhores jogadas dos streamers participantes')
        expect(page).to have_content("Categorias:\nJogos")
        expect(page).not_to have_content('Streamer: Fulaninho')
        expect(page).not_to have_content('ASMR')
      end
      it '2 categories' do
        admin = create(:user, :admin)
        create(:streamer, name: 'Fulaninho')
        create(:video_category, title: 'Jogos')
        create(:video_category, title: 'Ação')
        create(:video_category, title: 'ASMR')
        login_as admin, scope: :user
        visit root_path
        click_link 'Playlists'
        click_link 'Nova Playlist'
        within 'form' do
          fill_in 'Título', with: 'As melhores jogadas'
          fill_in 'Descrição', with: 'Playlist com as melhores jogadas dos streamers participantes'
          attach_file('playlist[playlist_cover]', 'spec/fixtures/files/avatar_placeholder.png')
          check 'Jogos'
          check 'Ação'
          click_button 'Criar Playlist'
        end

        expect(current_path).to eq(playlist_path(Playlist.last))
        expect(page).to have_css('div', text: 'Playlist criada com sucesso!')
        expect(page).to have_content('Título: As melhores jogadas')
        expect(page).to have_content('Descrição: Playlist com as melhores jogadas dos streamers participantes')
        expect(page).to have_content("Categorias:\nAção Jogos")
        expect(page).not_to have_content('ASMR')
      end
    end
  end
end
