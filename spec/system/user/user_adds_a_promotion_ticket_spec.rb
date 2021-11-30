require 'rails_helper'

describe 'User adds a promotion ticket' do
  context 'Successfully' do
    it 'with a discount amount less than maximum_value_reduction' do
      user = create(:user)
      create(:user_profile, user: user)
      create(:subscription_plan, title: 'Plano legal', value: 50)
      create(:promotion_ticket, title: 'BETA10STREAMER', discount: 20, maximum_value_reduction: 10)
      create(:promotion_ticket, title: 'GAME10STREAMER', discount: 10, maximum_value_reduction: 5)

      login_as user, scope: :user
      visit root_path
      click_link 'Planos'
      click_link 'Plano legal'
      within 'form' do
        fill_in 'Ticket de promoção', with: 'BETA10STREAMER'
        click_button 'Adicionar Ticket de promoção'
      end

      expect(page).to have_content('Ticket de promoção adicionado com sucesso!')
      expect(page).to have_content('Valor padrão: R$ 50,00')
      expect(page).to have_content('Valor atual: R$ 40,00')
      expect(page).to have_content('Assinar plano')
    end

    it 'with a discount amount less than maximum_value_reduction with dynamic value' do
      user = create(:user)
      create(:user_profile, user: user)
      sub = create(:subscription_plan, title: 'Plano legal', value: 50)
      create(:subscription_plan_value, value: 40, subscription_plan: sub)
      create(:promotion_ticket, title: 'GAME10STREAMER', discount: 10, maximum_value_reduction: 4)

      login_as user, scope: :user
      visit root_path
      click_link 'Planos'
      click_link 'Plano legal'
      within 'form' do
        fill_in 'Ticket de promoção', with: 'GAME10STREAMER'
        click_button 'Adicionar Ticket de promoção'
      end

      expect(page).to have_content('Ticket de promoção adicionado com sucesso!')
      expect(page).to have_content('Valor padrão: R$ 50,00')
      expect(page).to have_content('Valor atual: R$ 36,00')
      expect(page).to have_content('Assinar plano')
    end

    it 'with a discount amount greater than maximum_value_reduction' do
      user = create(:user)
      create(:user_profile, user: user)
      create(:subscription_plan, title: 'Plano legal', value: 1000)
      create(:promotion_ticket, title: 'GAME10STREAMER', discount: 10, maximum_value_reduction: 20)

      login_as user, scope: :user
      visit root_path
      click_link 'Planos'
      click_link 'Plano legal'
      within 'form' do
        fill_in 'Ticket de promoção', with: 'GAME10STREAMER'
        click_button 'Adicionar Ticket de promoção'
      end

      expect(page).to have_content('Ticket de promoção adicionado com sucesso!')
      expect(page).to have_content('Valor padrão: R$ 1.000,00')
      expect(page).to have_content('Valor atual: R$ 980,00')
      expect(page).to have_content('Assinar plano')
    end

    it 'with a discount amount greater than maximum_value_reduction with dynamic value' do
      user = create(:user)
      create(:user_profile, user: user)
      sub = create(:subscription_plan, title: 'Plano legal', value: 1000)
      create(:subscription_plan_value, value: 500, subscription_plan: sub)
      create(:promotion_ticket, title: 'GAME10STREAMER', discount: 10, maximum_value_reduction: 40)

      login_as user, scope: :user
      visit root_path
      click_link 'Planos'
      click_link 'Plano legal'
      within 'form' do
        fill_in 'Ticket de promoção', with: 'GAME10STREAMER'
        click_button 'Adicionar Ticket de promoção'
      end

      expect(page).to have_content('Ticket de promoção adicionado com sucesso!')
      expect(page).to have_content('Valor padrão: R$ 1.000,00')
      expect(page).to have_content('Valor atual: R$ 460,00')
      expect(page).to have_content('Assinar plano')
    end

    it 'updates promotion ticket' do
      user = create(:user)
      create(:user_profile, user: user)
      ticket = create(:promotion_ticket, title: 'BETA10STREAMER', discount: 20, maximum_value_reduction: 10)
      create(:promotion_ticket, title: 'STREAM10BETA', discount: 30, maximum_value_reduction: 15)
      create(:subscription_plan, title: 'Plano legal', value: 50, promotion_ticket: ticket)

      login_as user, scope: :user
      visit root_path
      click_link 'Planos'
      click_link 'Plano legal'
      within 'form' do
        fill_in 'Ticket de promoção', with: 'STREAM10BETA'
        click_button 'Adicionar Ticket de promoção'
      end

      expect(page).to have_content('Ticket de promoção adicionado com sucesso!')
      expect(page).to have_content('Valor padrão: R$ 50,00')
      expect(page).to have_content('Valor atual: R$ 35,00')
      expect(page).to have_content('Assinar plano')
      expect(page).to have_content('Ticket de promoção: STREAM10BETA')
    end

    it 'cannot must field blank' do
      user = create(:user)
      create(:user_profile, user: user)
      create(:subscription_plan, title: 'Plano legal', value: 50)
      create(:promotion_ticket, title: 'BETA10STREAMER', discount: 20)
      create(:promotion_ticket, title: 'GAME10STREAMER', discount: 10)

      login_as user, scope: :user
      visit root_path
      click_link 'Planos'
      click_link 'Plano legal'
      within 'form' do
        click_button 'Adicionar Ticket de promoção'
      end

      expect(page).to have_content('Ticket de promoção não existe')
      expect(page).to have_content('Valor padrão: R$ 50,00')
      expect(page).to have_content('Valor atual: R$ 50,00')
      expect(page).to have_content('Assinar plano')
    end

    it 'cannot add promotion_ticket maximum_uses equal 0' do
      user = create(:user)
      create(:user_profile, user: user)
      ticket = create(:promotion_ticket, title: 'BETA10STREAMER', maximum_uses: 1)
      ticket.maximum_uses = 0
      ticket.update!(maximum_uses: 0)
      create(:subscription_plan, title: 'Melhor plano', value: 60)

      login_as user, scope: :user
      visit root_path
      click_link 'Planos'
      click_link 'Melhor plano'
      within 'form' do
        fill_in 'Ticket de promoção', with: 'BETA10STREAMER'
        click_button 'Adicionar Ticket de promoção'
      end
      expect(page).to have_content('Ticket de promoção esgotado!')
      expect(page).to have_content('Valor padrão: R$ 60,00')
      expect(page).to have_content('Valor atual: R$ 60,00')
      expect(page).to have_content('Assinar plano') # LINHA 37 DO SUBSCRIPTION_PLAN_CONTROLLER ARRUMAR
    end
  end
end
