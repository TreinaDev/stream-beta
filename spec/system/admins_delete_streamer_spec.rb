require 'rails_helper'

describe 'Administrator delete streamer profile' do
  context 'successfully' do
    it 'from platform' do
      admin = create(:user, :admin)
      create(:streamer, name: 'Fulano')

      login_as admin, scope: :user
      visit root_path
      click_link 'Streamers'
      click_link 'Fulano'
      click_link 'Excluir Streamer'

      expect(Streamer.count).to eq 0
      expect(current_path).to eq streamers_path
    end
  end
  context 'fails' do
    it 'due to admin not logged in' do
      create(:streamer, name: 'Fulano')

      visit root_path
      click_link 'Streamers'
      click_link 'Fulano'

      expect(page).not_to have_link 'Excluir Streamer'
      expect(Streamer.count).to eq 1
    end
  end
end