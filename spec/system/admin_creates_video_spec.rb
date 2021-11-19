require 'rails_helper'

describe 'Administrator creates video' do
  it 'successfully' do
    admin = create(:user, :admin)
    create(:streamer, name: 'DarkStar')

    login_as admin, scope: :user
    visit root_path
    click_link 'Vídeos'
    click_link 'Novo vídeo'
    within 'form' do
      fill_in 'Título', with: 'Vídeo novo'
      fill_in 'Duração', with: '00:59:12'
      fill_in 'URL do vídeo', with: 'https://vimeo.com/123456789'
      fill_in 'Faixa etária', with: '18'
      select 'DarkStar', from: 'Streamer'
      click_button 'Criar Vídeo'
    end

    expect(current_path).to eq(video_path(Video.last))
    expect(page).to have_css('div', text: 'Vídeo criado com sucesso!')
    expect(page).to have_content('Vídeo novo')
    expect(page).to have_content('00:59:12')
    expect(page).to have_content('https://vimeo.com/123456789')
    expect(page).to have_content('18')
  end

  it 'but fails due to missing fields' do
    admin = create(:user, :admin)

    login_as admin, scope: :user
    visit root_path

    click_link 'Vídeos'
    click_link 'Novo vídeo'
    within 'form' do
      click_button 'Criar Vídeo'
    end

    expect(current_path).to eq(videos_path)
    expect(page).to have_content('Título não pode ficar em branco')
    expect(page).to have_content('Duração não pode ficar em branco')
    expect(page).to have_content('URL do vídeo não pode ficar em branco')
    expect(page).to have_content('Faixa etária não pode ficar em branco')
  end

  it 'but fails due to not being an admin' do
    user = create(:user)
    create(:user_profile, user: user)

    login_as user, scope: :user
    visit root_path
    click_link 'Vídeos'

    expect(page).to have_no_link('Novo vídeo')
  end
end
