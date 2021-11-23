require 'rails_helper'

describe 'User creates user profile' do
  context 'when logged in as an user' do
    it 'successfully' do
      user = create(:user)
      birthdate = 20.years.ago.to_date

      login_as user, scope: :user
      visit root_path
      click_link 'Streamers'

      within 'form' do
        fill_in 'Nome Completo', with: 'Rogerinho'
        fill_in 'Nome Social', with: 'Ro'
        fill_in 'Data de Nascimento', with: birthdate
        fill_in 'CPF', with: '30914741276'
        fill_in 'CEP', with: '37564-000'
        fill_in 'Endereço (Rua e Número)', with: 'Rua Interlagos, 9000'
        fill_in 'Endereço (Bairro e Complemento)', with: 'Bairro Olivia, casa'
        fill_in 'Cidade', with: 'Borda da Mata'
        fill_in 'Estado', with: 'Minas Gerais'
        fill_in 'País', with: 'Brasil'
        click_button 'Criar Perfil'
      end

      expect(current_path).to eq(user_profile_path(user.user_profile))
      expect(page).to have_content('Perfil criado com sucesso!')
      expect(page).to have_content('Rogerinho')
      expect(page).to have_content('Ro')
      expect(page).to have_content(I18n.l(birthdate))
      expect(page).to have_content('309.147.412-76')
      expect(page).to have_content('37564-000')
      expect(page).to have_content('Rua Interlagos, 9000')
      expect(page).to have_content('Bairro Olivia, casa')
      expect(page).to have_content('Borda da Mata')
      expect(page).to have_content('Minas Gerais')
      expect(page).to have_content('Brasil')
    end

    it 'but fails due to missing fields' do
      user = create(:user)

      login_as user, scope: :user
      visit root_path
      click_link 'Streamers'

      within 'form' do
        click_button 'Criar Perfil'
      end

      expect(page).to have_content('Nome Completo não pode ficar em branco')
      expect(page).to have_content('Nome Social não pode ficar em branco')
      expect(page).to have_content('Data de Nascimento não pode ficar em branco')
      expect(page).to have_content('CPF não pode ficar em branco')
      expect(page).to have_content('CEP não pode ficar em branco')
      expect(page).to have_content('Endereço (Rua e Número) não pode ficar em branco')
      expect(page).to have_content('Endereço (Bairro e Complemento) não pode ficar em branco')
      expect(page).to have_content('Cidade não pode ficar em branco')
      expect(page).to have_content('Estado não pode ficar em branco')
      expect(page).to have_content('País não pode ficar em branco')
      expect(user.user_profile).to be_nil
    end

    it 'and fails due to duplicated cpf' do
      user = create(:user)
      cpf = '30914741276'
      create(:user_profile, cpf: cpf)
      birthdate = 20.years.ago.to_date

      login_as user, scope: :user
      visit root_path
      click_link 'Streamers'

      within 'form' do
        fill_in 'Nome Completo', with: 'Rogerinho'
        fill_in 'Nome Social', with: 'Ro'
        fill_in 'Data de Nascimento', with: birthdate
        fill_in 'CPF', with: cpf
        fill_in 'CEP', with: '37564-000'
        fill_in 'Endereço (Rua e Número)', with: 'Rua Interlagos, 9000'
        fill_in 'Endereço (Bairro e Complemento)', with: 'Bairro Olivia, casa'
        fill_in 'Cidade', with: 'Borda da Mata'
        fill_in 'Estado', with: 'Minas Gerais'
        fill_in 'País', with: 'Brasil'
        click_button 'Criar Perfil'
      end

      expect(page).to have_content('CPF já está em uso')
      expect(user.user_profile).to be_nil
    end

    it 'and does not have a profile yet' do
      user = create(:user)

      login_as user, scope: :user
      visit root_path
      click_link 'Streamers'

      expect(current_path).to eq(new_user_profile_path)
      expect(page).to have_content('Preencha seu perfil para continuar navegando')
    end

    it 'and already has an user profile but tries to create a new one' do
      user = create(:user)
      create(:user_profile, full_name: 'Carlos da Silva', user: user)

      login_as user, scope: :user
      visit new_user_profile_path

      expect(current_path).to eq(user_profile_path(user.user_profile))
      expect(page).to have_css('div', text: 'Usuário já possui perfil cadastrado!')
      expect(page).to have_content('Nome Completo: Carlos da Silva')
    end
  end

  context 'when not authenticated' do
    it 'cannot create new user profile' do
      visit new_user_profile_path

      expect(current_path).to eq(new_user_session_path)
      expect(page).to have_content('Para continuar, efetue login ou registre-se.')
    end
  end
end
