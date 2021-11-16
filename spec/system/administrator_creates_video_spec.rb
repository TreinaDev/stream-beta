require 'rails_helper'

describe 'Administrator creates video' do
  it 'successfully' do
    admin = create(:user, :admin)

    login_as admin, scope: :user
    visit root_path
    click_link 'Vídeos'
    click_link 'Novo vídeo'
    within 'form' do
      fill_in 'Título', with: 'Vídeo novo'
      fill_in 'Duração', with: '00:59:12'
      fill_in 'URL do vídeo', with: 'https://vimeo.com/123456789'
      fill_in 'Faixa etária', with: '18'
      click_button 'Criar Vídeo'
    end

    expect(current_path).to eq(video_path(Video.last))
    expect(page).to have_content('Vídeo criado com sucesso!')
    expect(page).to have_content('Vídeo novo')
    expect(page).to have_content('00:59:12')
    expect(page).to have_content('https://vimeo.com/123456789')
    expect(page).to have_content('18')
  end
end
