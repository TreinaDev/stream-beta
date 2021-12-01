require 'rails_helper'

describe 'Administrator add category to video' do
  context 'create video' do
    context 'successfully' do
      it 'just one' do
        admin = create(:user, :admin)
        create(:video_category, title: 'Jogos')
        create(:video_category, title: 'ASMR')
        create(:streamer, name: 'DarkStar')

        login_as admin, scope: :user
        visit root_path
        click_link 'Vídeos'
        click_link 'Novo vídeo'
        within 'form' do
          fill_in 'Título', with: 'Jogadas eletrizantes'
          fill_in 'Duração', with: '00:59:12'
          fill_in 'URL do vídeo', with: 'https://vimeo.com/123456789'
          fill_in 'Faixa etária', with: '10'
          select 'DarkStar', from: 'Streamer'
          check 'Jogos'
          click_button 'Criar Vídeo'
        end

        expect(current_path).to eq(video_path(Video.last))
        expect(page).to have_css('div', text: 'Vídeo criado com sucesso!')
        expect(page).to have_content('Título: Jogadas eletrizantes')
        expect(page).to have_content("Categorias:\nJogos")
        expect(page).not_to have_content('ASMR')
      end
      it '2 categories' do
        admin = create(:user, :admin)
        create(:streamer, name: 'DarkStar')
        create(:video_category, title: 'Jogos')
        create(:video_category, title: 'Ação')
        create(:video_category, title: 'ASMR')
        login_as admin, scope: :user
        visit root_path
        click_link 'Vídeos'
        click_link 'Novo vídeo'
        within 'form' do
          fill_in 'Título', with: 'As melhores jogadas'
          fill_in 'Duração', with: '00:59:12'
          fill_in 'URL do vídeo', with: 'https://vimeo.com/123456789'
          fill_in 'Faixa etária', with: '10'
          select 'DarkStar', from: 'Streamer'
          check 'Jogos'
          check 'Ação'
          click_button 'Criar Vídeo'
        end

        expect(current_path).to eq(video_path(Video.last))
        expect(page).to have_css('div', text: 'Vídeo criado com sucesso!')
        expect(page).to have_content('Título: As melhores jogadas')
        expect(page).to have_content("Categorias:\nAção Jogos")
        expect(page).not_to have_content('ASMR')
      end
    end
  end
end
