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
    it 'successfully with videos' do
      user = create(:user)
      create(:user_profile, user: user)
      video = create(:video, title: 'Vídeo engraçado')
      create(:video, title: 'Vídeo chato')
      VideoHistory.create!(user: user, video: video)

      login_as user, scope: :user
      visit root_path
      click_link 'Área do Assinante'
      click_link 'Histórico de Vídeos'

      expect(current_path).to eq(user_video_history_path)
      expect(page).to have_css('h1', text: 'Histórico de Vídeos')
      expect(page).not_to have_css('p', text: 'Você ainda não assistiu nenhum vídeo')
      expect(page).to have_content('Vídeo engraçado')
      expect(page).not_to have_content('Vídeo chato')
    end
  end

  context 'when logged in as an admin' do
    it "and can't access the video history page" do
      admin = create(:user, :admin)

      login_as admin, scope: :user
      visit user_video_history_path

      expect(current_path).to eq(admin_home_index_path)
      expect(page).to have_css('div', text: 'Acesso não autorizado!')
      expect(page).to have_css('h2', text: 'Página do Admin')
    end
  end

  context 'when unauthenticated' do
    it "and can't access the purchase history page" do
      visit user_video_history_path

      expect(current_path).to eq(new_user_session_path)
      expect(page).to have_css('div', text: 'Para continuar, efetue login ou registre-se.')
    end
  end
end
