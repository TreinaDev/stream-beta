require 'rails_helper'

describe 'Admin account management' do
  context 'log in' do
    it 'successfully' do
      User.create!(email: 'john@gamestream.com.br', password: '123456789')

      visit root_path
      click_link 'Entrar'
      fill_in 'E-mail', with: 'john@gamestream.com.br'
      fill_in 'Senha', with: '123456789'
      click_button 'Entrar'

      expect(page).to have_content('Login efetuado com sucesso!')
      expect(page).to have_content('john@gamestream.com.br')
      expect(page).not_to have_link('Entrar')
      expect(page).to have_link('Sair')
    end

    it 'cannot log in with blank fields' do
      User.create!(email: 'john@gamestream.com.br', password: '123456789')

      visit root_path
      click_link 'Entrar'
      fill_in 'E-mail', with: ''
      fill_in 'Senha', with: ''
      click_button 'Entrar'

      expect(page).to have_content('E-mail ou senha inválida.')
      expect(page).to have_button('Entrar')
      expect(page).not_to have_link('Sair')
    end

    it 'See admin page' do
      User.create!(email: 'john@gamestream.com.br', password: '123456789', admin: true)

      visit root_path
      click_link 'Entrar'
      fill_in 'E-mail', with: 'john@gamestream.com.br'
      fill_in 'Senha', with: '123456789'
      click_button 'Entrar'

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
      click_link 'Sair'

      expect(current_path).to eq(root_path)
      expect(page).to have_content('Saiu com sucesso.')
      expect(page).not_to have_content('john@gamestream.com.br')
      expect(page).to have_link('Entrar')
      expect(page).not_to have_link('Sair')
    end
  end
end
