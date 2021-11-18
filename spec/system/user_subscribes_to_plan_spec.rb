require 'rails_helper'

describe 'User subscribes to plan' do
  context 'when authenticated' do
    it 'successfully with default value' do
      user = create(:user)
      create(:user_profile, user: user)
      plan = create(:subscription_plan, title: 'Plano legal')

      login_as user, scope: :user
      visit root_path
      click_link 'Planos'
      click_link 'Plano legal'
      click_link 'Assinar plano'
      click_button 'Confirmar assinatura'

      expect(current_path).to eq(subscription_plan_path(plan))
      expect(page).to have_css('div', text: 'Assinatura realizada com sucesso!')
      expect(page).to have_no_content('Assinar plano')
      expect(user.subscription_plans.count).to eq 1
    end

    it 'successfully with dynamic value' do
      # TODO: Montar teste quando houver SubscriptionPlanValue válido no período
    end

    it 'but fails due to payment not authorized' do
      # TODO: Necessário comunicação com API de pagamentos
    end
  end

  context 'when not authenticated' do
    # TODO: Montar teste pra usuário não autenticado
  end
end
