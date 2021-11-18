require 'rails_helper'

describe 'create accont' do
  context 'user' do
    it 'successfully' do
      visit root_path
      click_link 'Registrar'
      fill_in 'E-mail', with: 'user@email.com'
      fill_in 'Senha (Mínimo', with: '123456'
      fill_in 'Confirmação de Senha', with: '123456'
      click_button 'Registrar'

      expect(page).to have_content('Login efetuado com sucesso')
      expect(page).to have_link('Sair')
      expect(page).not_to have_content('Registrar')
      expect(current_path).not_to eq(admin_home_index_path)
    end
  end

  context 'admin' do
    it 'successfully' do
      visit root_path
      click_link 'Registrar'
      fill_in 'E-mail', with: 'admin@gamestream.com.br'
      fill_in 'Senha (Mínimo', with: '123456'
      fill_in 'Confirmação de Senha', with: '123456'
      click_button 'Registrar'

      expect(page).to have_content('Login efetuado com sucesso')
      expect(page).to have_link('Sair')
      expect(page).not_to have_content('Registrar')
      expect(current_path).to eq(admin_home_index_path)
    end
  end
end
