require 'rails_helper'

describe 'User accesses purchase history page' do
  context 'when logged in as an user' do
    it 'successfully with no subscription_plans' do
      user = create(:user)
      create(:user_profile, user: user)
      create(:subscription_plan, title: 'Plano que não foi vinculado')

      login_as user, scope: :user
      visit root_path
      click_link 'Área do Assinante'
      click_link 'Histórico de Compras'

      expect(current_path).to eq(user_purchase_history_path)
      expect(page).to have_css('h1', text: 'Histórico de Compras')
      expect(page).to have_css('p', text: 'Você ainda não possui assinaturas ativas')
      expect(page).to have_css('p', text: 'Você ainda não possui vídeos avulsos')
      expect(page).to have_no_content('Plano que não foi vinculado')
    end

    it 'successfully with subscription_plans' do
      user = create(:user)
      create(:user_profile, user: user)
      plan1 = create(:subscription_plan, title: 'Plano que foi vinculado')
      create(:subscription_plan, title: 'Plano que não foi vinculado')
      user.subscription_plans << plan1

      login_as user, scope: :user
      visit root_path
      click_link 'Área do Assinante'
      click_link 'Histórico de Compras'

      expect(current_path).to eq(user_purchase_history_path)
      expect(page).to have_css('h1', text: 'Histórico de Compras')
      expect(page).to have_css('a', text: 'Plano que foi vinculado')
      expect(page).to have_css('p', text: 'Você ainda não possui vídeos avulsos')
      expect(page).to have_no_content('Plano que não foi vinculado')
      expect(page).to have_no_css('p', text: 'Você ainda não possui assinaturas ativas')
    end

    it 'successfully with no videos' do
      user = create(:user)
      create(:user_profile, user: user)
      create(:video, title: 'Vídeo que não foi vinculado')

      login_as user, scope: :user
      visit root_path
      click_link 'Área do Assinante'
      click_link 'Histórico de Compras'

      expect(current_path).to eq(user_purchase_history_path)
      expect(page).to have_css('h1', text: 'Histórico de Compras')
      expect(page).to have_css('p', text: 'Você ainda não possui assinaturas ativas')
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
      click_link 'Histórico de Compras'

      expect(current_path).to eq(user_purchase_history_path)
      expect(page).to have_css('h1', text: 'Histórico de Compras')
      expect(page).to have_css('a', text: 'Vídeo que foi vinculado')
      expect(page).to have_no_content('Vídeo que não foi vinculado')
      expect(page).to have_no_css('p', text: 'Você ainda não possui vídeos avulsos')
      expect(page).to have_css('p', text: 'Você ainda não possui assinaturas ativas')
    end
  end

  context 'when logged in as an admin' do
    it "and can't access the purchase history page" do
      admin = create(:user, :admin)

      login_as admin, scope: :user
      visit user_purchase_history_path

      expect(current_path).to eq(admin_home_index_path)
      expect(page).to have_css('div', text: 'Acesso não autorizado!')
      expect(page).to have_css('h2', text: 'Página do Admin')
    end
  end

  context 'when unauthenticated' do
    it "and can't access the purchase history page" do
      visit user_purchase_history_path

      expect(current_path).to eq(new_user_session_path)
      expect(page).to have_css('div', text: 'Para continuar, efetue login ou registre-se.')
    end
  end
end
