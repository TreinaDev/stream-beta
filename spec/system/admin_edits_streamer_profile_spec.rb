require 'rails_helper'

describe 'Administrator edit streamer profile' do
  context 'successfully' do
    it 'changes streamer name' do
      admin = create(:user, :admin)
      create(:streamer, name: 'Fulano')

      login_as admin, scope: :user
      visit root_path
      click_link 'Streamers'
      click_link 'Fulano'
      click_link 'Editar Streamer'
      within 'form' do
        fill_in 'Nome', with: 'Sicrano'
        click_button 'Atualizar Streamer'
      end

      expect(current_path).to eq streamer_path(Streamer.last)
      expect(page).to have_content('Cadastro atualizado com sucesso!')
      expect(page).to have_content('Nome: Sicrano')
    end

    it 'changes streamer avatar' do
      admin = create(:user, :admin)
      create(:streamer, name: 'Fulano')

      login_as admin, scope: :user
      visit root_path
      click_link 'Streamers'
      click_link 'Fulano'
      click_link 'Editar Streamer'
      within 'form' do
        attach_file('streamer[avatar]', 'spec/fixtures/files/avatar_placeholder.png')
        click_button 'Atualizar Streamer'
      end

      expect(current_path).to eq streamer_path(Streamer.last)
      expect(page).to have_content('Cadastro atualizado com sucesso!')
      expect(page).to have_content('Nome: Sicrano')
    end
  end
end
