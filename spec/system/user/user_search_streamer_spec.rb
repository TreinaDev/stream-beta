require 'rails_helper'

describe 'User search' do
  context 'successfully' do
    it 'with 2 streamers' do
      user = create(:user)
      create(:user_profile, user: user)
      create(:streamer, name: 'joaozinho')
      create(:streamer, name: 'maria')

      login_as user, scope: :user
      visit root_path
      click_on 'Streamers'
      fill_in 'Busca:', with: 'maria'
      click_button 'Pesquisar'

      expect(current_path).to eq(search_streamers_path)
      expect(page).to have_content('maria')
      expect(page).to have_content('Streamers')
      expect(page).not_to have_content('joaozinho')
    end
    it 'with nothing' do
      user = create(:user)
      create(:user_profile, user: user)

      login_as user, scope: :user
      visit root_path
      click_on 'Streamers'
      fill_in 'Busca:', with: 'maria'
      click_button 'Pesquisar'

      expect(current_path).to eq(search_streamers_path)
      expect(page).to have_content('Streamers')
      expect(page).to have_content('Nenhum streamer encontrado')
    end
  end
end
