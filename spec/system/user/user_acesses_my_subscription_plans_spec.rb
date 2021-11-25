require 'rails_helper'

describe "User accesses 'my_subscription_plans'" do
  context 'when logged in as an user' do
    it 'successfully with no subscription_plans' do
      user = create(:user)
      create(:user_profile, user: user)
      create(:subscription_plan, title: 'Plano que não foi vinculado')

      login_as user, scope: :user
      visit root_path
      click_link 'Área do Assinante'
      click_link 'Minhas Assinaturas'

      expect(current_path).to eq(user_my_subscription_plans_path)
      expect(page).to have_css('h1', text: 'Minhas Assinaturas')
      expect(page).to have_css('p', text: 'Você ainda não possui assinaturas ativas')
      expect(page).to have_no_content('Plano que não foi vinculado')
    end

    it 'successfully with subscription_plans' do
      user = create(:user)
      create(:user_profile, user: user)
      plan1 = create(:subscription_plan, title: 'Plano que foi vinculado')
      create(:subscription_plan, title: 'Plano que não foi vinculado')
      user.subscription_plans += [plan1]

      login_as user, scope: :user
      visit root_path
      click_link 'Área do Assinante'
      click_link 'Minhas Assinaturas'

      expect(current_path).to eq(user_my_subscription_plans_path)
      expect(page).to have_css('h1', text: 'Minhas Assinaturas')
      expect(page).to have_css('a', text: 'Plano que foi vinculado')
      expect(page).to have_no_content('Plano que não foi vinculado')
      expect(page).to have_no_css('p', text: 'Você ainda não possui assinaturas ativas')
    end
  end

  context 'when logged in as an admin' do
    it "and can't access the purchase history page" do
      admin = create(:user, :admin)

      login_as admin, scope: :user
      visit user_my_subscription_plans_path

      expect(current_path).to eq(admin_home_index_path)
      expect(page).to have_css('div', text: 'Acesso não autorizado!')
      expect(page).to have_css('h2', text: 'Página do Admin')
    end
  end

  context 'when unauthenticated' do
    it "and can't access the purchase history page" do
      visit user_my_subscription_plans_path

      expect(current_path).to eq(new_user_session_path)
      expect(page).to have_css('div', text: 'Para continuar, efetue login ou registre-se.')
    end
  end
end
