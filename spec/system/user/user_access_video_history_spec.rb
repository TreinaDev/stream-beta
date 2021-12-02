require 'rails_helper'

describe 'User accesses video history page' do
  context 'when logged in as an user' do
    it 'successfully with no video watched' do
      user = create(:user)
      create(:user_profile, user: user)
      create(:video, title: 'Vídeo não assistido')

      login_as user, scope: :user
      visit root_path
      click_link 'Área do Assinante'
      click_link 'Histórico de Vídeos'

      expect(current_path).to eq(user_video_history_path)
      expect(page).to have_css('h1', text: 'Histórico de Vídeos')
      expect(page).to have_css('p', text: 'Você ainda não assistiu nenhum vídeo')
      expect(page).not_to have_content('Vídeo não assistido')
    end
  end
end
