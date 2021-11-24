require 'rails_helper'

describe 'User views streamer videos' do
  context 'successfully' do
    it 'when there is at least one video' do
      user = create(:user)
      create(:user_profile, user: user)
      streamer = create(:streamer, name: 'DarkStar')
      create(:video, title: 'Dicas de BF', streamer: streamer)
      create(:video, title: 'As melhores jogadas da semana', streamer: streamer)

      login_as user, scope: :user
      visit root_path
      click_link 'Streamers'
      click_link 'DarkStar'

      expect(current_path).to eq streamer_path(streamer)
      expect(page).to have_content('Dicas de BF')
      expect(page).to have_content('As melhores jogadas da semana')
    end

    it 'and does not see videos from other streamers' do
      user = create(:user)
      create(:user_profile, user: user)
      streamer = create(:streamer, name: 'DarkStar')
      create(:video, title: 'Dicas de BF', streamer: streamer)
      other_streamer = create(:streamer, name: 'ShinyStar')
      create(:video, title: 'Dicas de CoD', streamer: other_streamer)

      login_as user, scope: :user
      visit root_path
      click_link 'Streamers'
      click_link 'DarkStar'

      expect(current_path).to eq streamer_path(streamer)
      expect(page).to have_content('Dicas de BF')
      expect(page).to have_no_content('Dicas de CoD')
    end

    it 'and sees a message when there are no videos for the current streamer' do
      user = create(:user)
      create(:user_profile, user: user)
      streamer = create(:streamer, name: 'DarkStar')

      login_as user, scope: :user
      visit root_path
      click_link 'Streamers'
      click_link 'DarkStar'

      expect(current_path).to eq streamer_path(streamer)
      expect(page).to have_content('Nenhum vídeo cadastrado')
    end
  end
end
