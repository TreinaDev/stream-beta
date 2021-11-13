require 'rails_helper'

describe 'Admin account management' do
  context 'log in' do
    it 'successfully' do
      john = User.create!(email: 'john@gamestream.com.br', password: '123456789')

      visit root_path
      click_on 'Login'
      fill_in 'Email', with: john.email
      fill_in 'Password', with: john.password
      click_on 'Log in'

      expect(page).to have_content('Signed in successfully.')
      expect(page).to have_content('john@gamestream.com.br')
      expect(page).not_to have_content('Login')
      expect(page).to have_content('Logout')
    end

    it 'cannot log in with blank fields' do
      john = User.create!(email: 'john@gamestream.com.br', password: '123456789')

      visit root_path
      click_on 'Login'
      fill_in 'Email', with: ''
      fill_in 'Password', with: ''
      click_on 'Log in'

      expect(page).to have_content('Invalid Email or password.')
      expect(page).to have_content('Log in')
      expect(page).not_to have_content('Logout')
    end

    it 'See admin page' do
      john = User.create!(email: 'john@gamestream.com.br', password: '123456789', admin: true)

      visit root_path
      click_on 'Login'
      fill_in 'Email', with: john.email
      fill_in 'Password', with: john.password
      click_on 'Log in'


      expect(page).to have_content('Página do Admin')
      expect(page).to have_content('john@gamestream.com.br')
      expect(page).to have_content('Criar Playlist')
    end

  end

  context 'log out' do
    it 'successfully' do
      john = User.create!(email: 'john@gamestream.com.br', password: '123456789')

      login_as john, scope: :user
      visit root_path
      click_on 'Logout'

      expect(page).to have_content('Signed out successfully.')
      expect(page).not_to have_content('john@gamestream.com.br')
      expect(page).to have_content('Login')
      expect(page).not_to have_content('Logout')
    end
  end
end
