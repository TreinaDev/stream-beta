require 'rails_helper'

describe 'User subscribes to plan' do
  context 'when authenticated' do
    it 'successfully with default value' do
      # TODO: Ajustar teste quando for implementada a API de pagamentos e os meios de pagamento forem cadastrados
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
      # TODO: Ajustar teste quando for implementada a API de pagamentos e os meios de pagamento forem cadastrados
      user = create(:user)
      create(:user_profile, user: user)
      plan = create(:subscription_plan, title: 'Plano legal')
      create(:subscription_plan_value, start_date: Date.current, end_date: 3.days.from_now, value: 20,
                                       subscription_plan: plan)

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

    it 'but fails due to payment not authorized' do
      # TODO: Ajustar teste quando for implementada a API de pagamentos e os meios de pagamento forem cadastrados
      user = create(:user)
      create(:user_profile, user: user)
      create(:subscription_plan, title: 'Plano legal')
      allow_any_instance_of(UserSubscriptionPlan).to receive(:validate_payment).and_return(false)

      login_as user, scope: :user
      visit root_path
      click_link 'Planos'
      click_link 'Plano legal'
      click_link 'Assinar plano'
      click_button 'Confirmar assinatura'

      expect(page).to have_button('Confirmar assinatura')
      expect(page).to have_no_content('Assinar plano')
      expect(page).to have_css('div', text: 'Pagamento não autorizado')
      expect(user.subscription_plans.count).to eq 0
    end
  end

  context 'when not authenticated' do
    # TODO: Ajustar teste quando for implementada a API de pagamentos e os meios de pagamento forem cadastrados
    it 'trying to purchase a plan will redirect to sign_in screen' do
      plan = create(:subscription_plan, title: 'Plano legal')

      visit root_path
      click_link 'Planos'
      click_link 'Plano legal'
      click_link 'Assinar plano'

      expect(current_path).to eq(new_user_session_path)
    end
  end
end
