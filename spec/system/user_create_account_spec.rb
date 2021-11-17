require 'rails_helper'

describe 'create accont' do
  context 'user' do
    it 'successfully' do
      visit root_path
      click_on 'Registrar conta'
      fill_in 'Email', with: 'user@email.com'
      fill_in 'Password', with: '123456'
      fill_in 'Password confirmation', with: '123456'
      click_on 'Sign up'

      expect(page).to have_content('Login efetuado com sucesso')
      expect(page).to have_content('Logout')
      expect(page).not_to have_content('Registrar conta')
    end
  end
end
