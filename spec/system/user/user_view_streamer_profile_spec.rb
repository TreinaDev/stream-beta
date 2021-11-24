require 'rails_helper'

describe 'User views streamer profiles' do
  context 'successfully' do
    it 'when have one streamer' do
      user = create(:user)
      create(:user_profile, user: user)
      streamer = create(:streamer, name: 'Fulano', facebook_url: 'www.facebook.com/fulano',
                                   youtube_url: 'www.youtube.com/fulano',
                                   instagram_handle: 'www.instagram.com/fulano',
                                   twitter_handle: 'www.twitter.com/fulano')

      login_as user, scope: :user
      visit root_path
      click_link 'Streamers'
      click_link 'Fulano'

      expect(page).to have_content('Facebook: www.facebook.com/fulano')
      expect(page).to have_content('Youtube: www.youtube.com/fulano')
      expect(page).to have_content('Instagram: www.instagram.com/fulano')
      expect(page).to have_content('Twitter: www.twitter.com/fulano')
      expect(current_path).to eq streamer_path(streamer)
    end

    it 'cannot see inatives streamer' do
      user = create(:user)
      create(:user_profile, user: user)
      create(:streamer, name: 'Fulano', status: :inactive)

      login_as user, scope: :user
      visit root_path
      click_link 'Streamers'

      expect(page).not_to have_content('Fulano')
    end
  end
end
