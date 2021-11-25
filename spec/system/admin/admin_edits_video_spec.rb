require 'rails_helper'

describe 'Administrator edit playlist' do
  context 'successfully' do
    it 'changes a playlist' do
      admin = create(:user, :admin)
      streamer = create(:streamer, name: 'Streamer bom')
      create(:streamer, name: 'Streamer otimo')
      create(:video, title: 'Video muito bom', duration: '00:10:10', video_url: 'https://vimeo.com/123456789',
                     maturity_rating: '12', streamer: streamer)

      login_as admin, scope: :user
      visit root_path
      click_on 'Vídeos'
      click_on 'Video muito bom'
      click_on 'Editar Vídeo'
      within 'form' do
        fill_in 'Título', with: 'Vídeo otimo'
        fill_in 'Duração', with: '00:42:00'
        fill_in 'URL do vídeo', with: 'https://vimeo.com/987654321'
        fill_in 'Faixa etária', with: '14'
        select 'Streamer otimo', from: 'Streamer'
        click_on 'Atualizar Vídeo'
      end

      expect(current_path).to eq(video_path(Video.last))
      expect(page).to have_content('Vídeo atualizado com sucesso!')
      expect(page).to have_content('Vídeo otimo')
      expect(page).to have_content('00:42:00')
      expect(page).to have_content('https://vimeo.com/987654321')
      expect(page).to have_content('14')
    end

    it 'inactive a video' do
      admin = create(:user, :admin)
      create(:video, title: 'Vídeo ruim')

      login_as admin, scope: :user
      visit root_path
      click_link 'Vídeos'
      click_link 'Vídeo ruim'
      click_link 'Editar Vídeo'
      within 'form' do
        choose 'Inativo'
        click_button 'Atualizar Vídeo'
      end

      expect(current_path).to eq video_path(Video.last)
      expect(page).to have_content('Inativo')
    end

    it 'active a video' do
      admin = create(:user, :admin)
      create(:video, title: 'Vídeo ruim', status: :inactive)

      login_as admin, scope: :user
      visit root_path
      click_link 'Vídeos Inativos'
      click_link 'Vídeo ruim'
      click_link 'Editar Vídeo'
      within 'form' do
        choose 'Ativo'
        click_button 'Atualizar Vídeo'
      end

      expect(current_path).to eq video_path(Video.last)
      expect(page).to have_content('Status: Ativo')
      expect(page).not_to have_content('Status: Inativo')
    end
  end
  context 'fails' do
    it 'due to admin not be logged in' do
      create(:user, :admin)
      create(:video, title: 'Vídeo bom')

      visit root_path
      click_link 'Vídeos'
      click_link 'Vídeo bom'

      expect(page).not_to have_link 'Editar Vídeo'
    end

    it 'due to empty fields' do
      admin = create(:user, :admin)
      create(:video, title: 'Vídeo bom')

      login_as admin, scope: :user
      visit root_path
      click_link 'Vídeos'
      click_link 'Vídeo bom'
      click_link 'Editar Vídeo'
      within 'form' do
        fill_in 'Título', with: ''
        click_button 'Atualizar Vídeo'
      end

      expect(current_path).to eq video_path(Video.last)
      expect(page).to have_content('Título não pode ficar em branco')
    end
  end
end
