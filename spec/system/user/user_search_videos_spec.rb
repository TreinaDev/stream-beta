require 'rails_helper'

describe 'videos' do
  context 'successfully' do
    context 'by title' do
      it 'with 2 videos' do
        user = create(:user)
        create(:user_profile, user: user)
        create(:video, title: 'Streamer fazendo coisas engraçadas')
        create(:video, title: 'Vídeo careta')

        login_as user, scope: :user
        visit root_path
        click_on 'Vídeos'
        fill_in 'Busca:', with: 'engraçadas'
        click_button 'Pesquisar'

        expect(current_path).to eq(search_videos_path)
        expect(page).to have_content('Streamer fazendo coisas engraçadas')
        expect(page).to have_content('Vídeos')
        expect(page).not_to have_content('Vídeo careta')
      end
    end
    context 'by streamer' do
      it 'with 2 streamers' do
        user = create(:user)
        create(:user_profile, user: user)
        streamer = create(:streamer, name: 'palhaço')
        create(:streamer, name: 'chato')
        create(:video, title: 'Streamer fazendo coisas engraçadas', streamer: streamer)
        create(:video, title: 'Vídeo careta')

        login_as user, scope: :user
        visit root_path
        click_on 'Vídeos'
        fill_in 'Busca:', with: 'palhaço'
        click_button 'Pesquisar'

        expect(current_path).to eq(search_videos_path)
        expect(page).not_to have_content('Nenhum vídeo encontrado')
        expect(page).to have_content('Streamer fazendo coisas engraçadas')
        expect(page).to have_content('Vídeos')
        expect(page).not_to have_content('Vídeo careta')
      end
    end
    context 'by category' do
      it 'with 2 category' do
        user = create(:user)
        create(:user_profile, user: user)
        create(:video_category, title: 'ASMR')
        create(:video, title: 'Vídeo careta')
        category = create(:video_category, title: 'Comédia')
        video = create(:video, title: 'Streamer fazendo coisas engraçadas')
        CategoryList.create!(video_category: category, categoriable: video)

        login_as user, scope: :user
        visit root_path
        click_on 'Vídeos'
        fill_in 'Busca:', with: 'Comédia'
        click_button 'Pesquisar'

        expect(current_path).to eq(search_videos_path)
        expect(page).to have_content('Vídeos')
        expect(page).not_to have_content('Nenhum vídeo encontrado')
        expect(page).to have_content('Streamer fazendo coisas engraçadas')
        expect(page).not_to have_content('Vídeo careta')
      end
    end
    it 'with nothing' do
      user = create(:user)
      create(:user_profile, user: user)

      login_as user, scope: :user
      visit root_path
      click_on 'Vídeos'
      fill_in 'Busca:', with: ' '
      click_button 'Pesquisar'

      expect(current_path).to eq(search_videos_path)
      expect(page).to have_content('Vídeos')
      expect(page).to have_content('Nenhum vídeo encontrado')
    end
    it 'no have duplicate' do
      user = create(:user)
      create(:user_profile, user: user)
      streamer = create(:streamer, name: 'engraçado')
      create(:video, title: 'Streamer muito engraçado', streamer: streamer)

      login_as user, scope: :user
      visit root_path
      click_on 'Vídeos'
      fill_in 'Busca:', with: 'engraçado'
      click_button 'Pesquisar'

      expect(current_path).to eq(search_videos_path)
      expect(page).to have_content('Streamer muito engraçado', count: 1)
    end
  end
end
