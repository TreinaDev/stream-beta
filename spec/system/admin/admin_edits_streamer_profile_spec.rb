require 'rails_helper'

describe 'Administrator edit streamer profile' do
  context 'successfully' do
    it 'changes streamer profile' do
      admin = create(:user, :admin)
      create(:streamer, name: 'Fulano')

      login_as admin, scope: :user
      visit root_path
      click_link 'Streamers'
      click_link 'Fulano'
      click_link 'Editar Streamer'
      within 'form' do
        fill_in 'Nome', with: 'Sicrano'
        attach_file('streamer[avatar]', 'spec/fixtures/files/avatar_placeholder_edition.png')
        fill_in 'Facebook', with: 'www.facebook.com/sicrano'
        fill_in 'Canal no Youtube', with: 'www.youtube.com/sicrano'
        fill_in 'Instagram', with: 'www.instagram.com/sicrano'
        fill_in 'Twitter', with: 'www.twitter.com/sicrano'
        click_button 'Atualizar Streamer'
      end

      expect(current_path).to eq streamer_path(Streamer.last)
      expect(page).to have_content('Cadastro atualizado com sucesso!')
      expect(page).to have_content('Nome: Sicrano')
      expect(page).to have_css("img[src*='avatar_placeholder_edition.png']")
      expect(page).to have_content('Facebook: www.facebook.com/sicrano')
      expect(page).to have_content('Youtube: www.youtube.com/sicrano')
      expect(page).to have_content('Instagram: www.instagram.com/sicrano')
      expect(page).to have_content('Twitter: www.twitter.com/sicrano')
    end

    it 'inactive a streamer' do
      admin = create(:user, :admin)
      create(:streamer, name: 'Fulano')

      login_as admin, scope: :user
      visit root_path
      click_link 'Streamers'
      click_link 'Fulano'
      click_link 'Editar Streamer'
      within 'form' do
        choose 'Inativo'
        click_button 'Atualizar Streamer'
      end

      expect(current_path).to eq streamer_path(Streamer.last)
      expect(page).to have_content('Estado: Inativo')
    end

    it 'active a streamer' do
      admin = create(:user, :admin)
      create(:streamer, name: 'Fulano', status: :inactive)

      login_as admin, scope: :user
      visit root_path
      click_link 'Streamers Inativos'
      click_link 'Fulano'
      click_link 'Editar Streamer'
      within 'form' do
        choose 'Ativo'
        click_button 'Atualizar Streamer'
      end

      expect(current_path).to eq streamer_path(Streamer.last)
      expect(page).to have_content('Estado: Ativo')
      expect(page).not_to have_content('Estado: Inativo')
    end
  end

  context 'fails' do
    it 'due to admin not be logged in' do
      create(:user, :admin)
      create(:streamer, name: 'Fulano')

      visit root_path
      click_link 'Streamers'
      click_link 'Fulano'

      expect(page).not_to have_link 'Editar Streamer'
    end

    it 'due to empty fields' do
      admin = create(:user, :admin)
      create(:streamer, name: 'Fulano')

      login_as admin, scope: :user
      visit root_path
      click_link 'Streamers'
      click_link 'Fulano'
      click_link 'Editar Streamer'
      within 'form' do
        fill_in 'Nome', with: ''
        click_button 'Atualizar Streamer'
      end

      expect(current_path).to eq streamer_path(Streamer.last)
      expect(page).to have_content('Nome não pode ficar em branco')
    end
  end
end
