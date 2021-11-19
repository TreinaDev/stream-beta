require 'rails_helper'

describe 'User views streamer videos' do
  it 'successfully' do
    user = create(:user)
    streamer = create(:streamer, name: 'DarkStar')
    create(:video, title: 'Dicas de BF', streamer: streamer)
    create(:video, title: 'As melhores jogadas da semana', streamer: streamer)
    other_streamer = create(:streamer, name: 'ShinyStar')
    create(:video, title: 'Dicas de CoD', streamer: other_streamer)

    login_as user, scope: :user
    visit root_path
    click_link 'Streamers'
    click_link 'DarkStar'

    expect(current_path).to eq streamer_path(streamer)
    expect(page).to have_content('Dicas de BF')
    expect(page).to have_content('As melhores jogadas da semana')
    expect(page).to have_no_content('Dicas de CoD')
  end
end
