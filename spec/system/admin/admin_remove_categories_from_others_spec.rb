require 'rails_helper'

describe 'Administrator remove category' do
  context 'in playlist' do
    it 'successfully' do
      admin = create(:user, :admin)
      create(:streamer, name: 'Fulaninho')
      playlist = create(:playlist, title: 'As melhores jogatinas')
      category_jogos = create(:video_category, title: 'Jogos')
      category_acao  = create(:video_category, title: 'Ação')
      create(:video_category, title: 'ASMR')
      CategoryList.create!(categoriable: playlist, video_category: category_jogos)
      CategoryList.create!(categoriable: playlist, video_category: category_acao)

      login_as admin, scope: :user
      visit root_path
      click_link 'Playlists'
      click_link 'As melhores jogatinas'
      click_link 'Editar'
      check 'Jogos'
      uncheck 'Ação'
      click_button 'Atualizar Playlist'

      expect(current_path).to eq(playlist_path(Playlist.last))
      expect(page).to have_content('Título: As melhores jogatinas')
      expect(page).to have_content("Categorias:\nJogos")
      expect(page).not_to have_content('ASMR')
      expect(page).not_to have_content('Ação')
      expect(page).to have_content('Playlist editada com sucesso!')
    end
  end
  context 'in video' do
    it 'successfully' do
      admin = create(:user, :admin)
      create(:streamer, name: 'Fulaninho')
      video = create(:video, title: 'A melhor jogatina')
      category_jogos = create(:video_category, title: 'Jogos')
      category_acao  = create(:video_category, title: 'Ação')
      create(:video_category, title: 'ASMR')
      CategoryList.create!(categoriable: video, video_category: category_jogos)
      CategoryList.create!(categoriable: video, video_category: category_acao)

      login_as admin, scope: :user
      visit root_path
      click_link 'Vídeos'
      click_link 'A melhor jogatina'
      click_link 'Editar'
      check 'Jogos'
      uncheck 'Ação'
      click_button 'Atualizar Vídeo'

      expect(current_path).to eq(video_path(Video.last))
      expect(page).to have_content('Título: A melhor jogatina')
      expect(page).to have_content("Categorias:\nJogos")
      expect(page).not_to have_content('ASMR')
      expect(page).not_to have_content('Ação')
      expect(page).to have_content('Vídeo atualizado com sucesso!')
    end
  end
end
