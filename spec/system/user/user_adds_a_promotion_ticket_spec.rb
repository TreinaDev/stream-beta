require 'rails_helper'

describe 'User adds a promotion ticket' do
  context 'Successfully' do
    it 'with a discount amount less than maximum_value_reduction' do
      user = create(:user)
      create(:user_profile, user: user)
      create(:subscription_plan, title: 'Plano legal', value: 50)
      create(:promotion_ticket, title: 'GAME10STREAMER', discount: 10)

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
      expect(page).to have_content('Valor atual: R$ 45,00')
      expect(page).to have_content('Assinar plano')
    end
  end
end
