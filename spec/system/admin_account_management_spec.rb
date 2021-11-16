require 'rails_helper'

describe 'Admin account management' do
  context 'log in' do
    it 'successfully' do
      User.create!(email: 'john@gamestream.com.br', password: '123456789')

      visit root_path
      click_on 'Login'
      fill_in 'Email', with: 'john@gamestream.com.br'
      fill_in 'Password', with: '123456789'
      click_on 'Log in'

      expect(page).to have_content('Login efetuado com sucesso!')
      expect(page).to have_content('john@gamestream.com.br')
      expect(page).not_to have_link('Login')
      expect(page).to have_link('Logout')
    end

    it 'cannot log in with blank fields' do
      User.create!(email: 'john@gamestream.com.br', password: '123456789')

      visit root_path
      click_on 'Login'
      fill_in 'Email', with: ''
      fill_in 'Password', with: ''
      click_on 'Log in'

      expect(page).to have_content('Email ou senha inválida.')
      expect(page).to have_button('Log in')
      expect(page).not_to have_link('Logout')
    end

    it 'See admin page' do
      User.create!(email: 'john@gamestream.com.br', password: '123456789', admin: true)

      visit root_path
      click_on 'Login'
      fill_in 'Email', with: 'john@gamestream.com.br'
      fill_in 'Password', with: '123456789'
      click_on 'Log in'

      expect(current_path).to eq(admin_home_index_path)
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

      expect(current_path).to eq(root_path)
      expect(page).to have_content('Saiu com sucesso.')
      expect(page).not_to have_content('john@gamestream.com.br')
      expect(page).to have_link('Login')
      expect(page).not_to have_link('Logout')
    end
  end
end
