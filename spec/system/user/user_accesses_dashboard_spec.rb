require 'rails_helper'

describe 'User accesses dashboard' do
  context 'when logged in as an user' do
    it 'successfully' do
      user = create(:user)
      create(:user_profile, user: user)

      login_as user, scope: :user
      visit root_path
      click_link 'Área do Assinante'

      expect(current_path).to eq(user_dashboard_path)
      expect(page).to have_css('h1', text: 'Área do Assinante')
      expect(page).to have_link('Histórico de Compras')
      expect(page).to have_link('Histórico de Consumo')
      expect(page).to have_link('Minhas Assinaturas')
      expect(page).to have_link('Meus Vídeos')
      expect(page).to have_link('Solicitações de Reembolso')
    end
  end

  context 'when logged in as an admin' do
    it "and doesn't see the dashboard link" do
      admin = create(:user, :admin)

      login_as admin, scope: :user
      visit root_path

      expect(current_path).to eq(admin_home_index_path)
      expect(page).to have_no_link('Área do Assinante')
      expect(page).to have_css('h2', text: 'Página do Admin')
    end

    it "and can't access the dashboard" do
      admin = create(:user, :admin)

      login_as admin, scope: :user
      visit user_dashboard_path

      expect(current_path).to eq(admin_home_index_path)
      expect(page).to have_css('div', text: 'Acesso não autorizado!')
      expect(page).to have_css('h2', text: 'Página do Admin')
    end
  end

  context 'when unauthenticated' do
    it "and doesn't see the dashboard link" do
      visit root_path

      expect(current_path).to eq(root_path)
      expect(page).to have_no_link('Área do Assinante')
    end

    it "and can't access the dashboard" do
      visit user_dashboard_path

      expect(current_path).to eq(new_user_session_path)
      expect(page).to have_css('div', text: 'Para continuar, efetue login ou registre-se.')
    end
  end
end
