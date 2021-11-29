require 'rails_helper'

describe "User accesses 'my_videos'" do
  context 'when logged in as an user' do
    it 'successfully with no videos' do
      user = create(:user)
      create(:user_profile, user: user)
      create(:video, title: 'Vídeo que não foi vinculado')

      login_as user, scope: :user
      visit root_path
      click_link 'Área do Assinante'
      click_link 'Meus Vídeos'

      expect(current_path).to eq(user_my_videos_path)
      expect(page).to have_css('h1', text: 'Meus Vídeos')
      expect(page).to have_css('p', text: 'Você ainda não possui vídeos avulsos')
      expect(page).to have_no_content('Vídeo que não foi vinculado')
    end

    it 'successfully with videos' do
      user = create(:user)
      create(:user_profile, user: user)
      video1 = create(:video, title: 'Vídeo que foi vinculado')
      create(:video, title: 'Vídeo que não foi vinculado')
      user.videos << video1

      login_as user, scope: :user
      visit root_path
      click_link 'Área do Assinante'
      click_link 'Meus Vídeos'

      expect(current_path).to eq(user_my_videos_path)
      expect(page).to have_css('h1', text: 'Meus Vídeos')
      expect(page).to have_css('a', text: 'Vídeo que foi vinculado')
      expect(page).to have_no_content('Vídeo que não foi vinculado')
      expect(page).to have_no_css('p', text: 'Você ainda não possui vídeos avulsos')
    end
  end

  context 'when logged in as an admin' do
    it "and can't access the purchase history page" do
      admin = create(:user, :admin)

      login_as admin, scope: :user
      visit user_my_videos_path

      expect(current_path).to eq(admin_home_index_path)
      expect(page).to have_css('div', text: 'Acesso não autorizado!')
      expect(page).to have_css('h2', text: 'Página do Admin')
    end
  end

  context 'when unauthenticated' do
    it "and can't access the purchase history page" do
      visit user_my_videos_path

      expect(current_path).to eq(new_user_session_path)
      expect(page).to have_css('div', text: 'Para continuar, efetue login ou registre-se.')
    end
  end
end
