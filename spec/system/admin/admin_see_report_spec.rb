require 'rails_helper'

describe 'Administrator see report' do
  context 'successfully' do
    it 'number subscriptions streamers' do
      admin = create(:user, :admin)
      streamer = create(:streamer, name: 'João')
      create(:streamer, name: 'Maria')
      subscription = create(:subscription_plan, streamer: streamer)
      8.times.each { create(:user_subscription_plan, subscription_plan: subscription) }
      login_as admin, scope: :user
      visit root_path
      click_on 'Relatório'

      expect(current_path).to eq(admin_report_path)
      expect(page).to have_content('Relatório')
      expect(page).to have_content('João 8')
      expect(page).to have_content('Maria 0')
    end
  end
end
