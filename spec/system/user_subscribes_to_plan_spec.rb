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
      click_button 'Criar Assinatura de Plano'

      subscription = user.user_subscription_plans.find_by(subscription_plan: plan)
      expect(current_path).to eq(subscription_plan_path(plan))
      expect(subscription).to be_approved
      expect(page).to have_css('div', text: 'Assinatura realizada com sucesso!')
      expect(page).to have_no_content('Assinar plano')
      expect(user.subscription_plans.count).to eq 1
    end

    it 'successfully with dynamic value' do
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
      click_button 'Criar Assinatura de Plano'

      subscription = user.user_subscription_plans.find_by(subscription_plan: plan)
      expect(subscription).to be_approved
      expect(current_path).to eq(subscription_plan_path(plan))
      expect(page).to have_css('div', text: 'Assinatura realizada com sucesso!')
      expect(page).to have_no_content('Assinar plano')
      expect(user.subscription_plans.count).to eq 1
    end

    it 'but fails due to payment not authorized' do
      user = create(:user)
      create(:user_profile, user: user)
      plan = create(:subscription_plan, title: 'Plano legal')
      allow_any_instance_of(UserSubscriptionPlan).to receive(:set_status).and_return(:rejected)

      login_as user, scope: :user
      visit root_path
      click_link 'Planos'
      click_link 'Plano legal'
      click_link 'Assinar plano'
      click_button 'Criar Assinatura de Plano'

      subscription = user.user_subscription_plans.find_by(subscription_plan: plan)
      expect(subscription).to be_rejected
      expect(current_path).to eq(subscription_plan_path(plan))
      expect(page).to have_css('div', text: 'Pagamento reprovado')
      expect(page).to have_link('Assinar plano')
      expect(user.subscription_plans.count).to eq 1
    end

    it 'and the payment status is pending' do
      user = create(:user)
      create(:user_profile, user: user)
      plan = create(:subscription_plan, title: 'Plano legal')
      allow_any_instance_of(UserSubscriptionPlan).to receive(:set_status).and_return(:pending)

      login_as user, scope: :user
      visit root_path
      click_link 'Planos'
      click_link 'Plano legal'
      click_link 'Assinar plano'
      click_button 'Criar Assinatura de Plano'

      subscription = user.user_subscription_plans.find_by(subscription_plan: plan)
      expect(subscription).to be_pending
      expect(current_path).to eq(subscription_plan_path(plan))
      expect(page).to have_css('div', text: 'Pagamento em análise')
      expect(page).to have_no_link('Assinar plano')
      expect(user.subscription_plans.count).to eq 1
    end
  end

  context 'when not authenticated' do
    it 'trying to purchase a plan will redirect to sign_in screen' do
      create(:subscription_plan, title: 'Plano legal')

      visit root_path
      click_link 'Planos'
      click_link 'Plano legal'
      click_link 'Assinar plano'

      expect(current_path).to eq(new_user_session_path)
    end
  end
end
