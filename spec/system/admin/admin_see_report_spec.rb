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
    it 'number subscriptions playlist' do
      admin = create(:user, :admin)
      playlist = create(:playlist, title: 'Playlist Interessante')
      create(:streamer, name: 'Playlist vazia')
      subscription = create(:subscription_plan, playlists: [playlist])
      8.times.each { create(:user_subscription_plan, subscription_plan: subscription) }
      login_as admin, scope: :user
      visit root_path
      click_on 'Relatório'

      expect(current_path).to eq(admin_report_path)
      expect(page).to have_content('Relatório')
      expect(page).to have_content('Playlist Interessante 8')
      expect(page).to have_content('Playlist vazia 0')
    end
    it 'number subscriptions videos' do
      admin = create(:user, :admin)
      video = create(:video, :allow_purchase, title: 'Vídeo Muito Popular')
      create(:video, :allow_purchase, title: 'video q ninguem compra')
      8.times.each { create(:user_video, video: video) }
      login_as admin, scope: :user
      visit root_path
      click_on 'Relatório'

      expect(current_path).to eq(admin_report_path)
      expect(page).to have_content('Relatório')
      expect(page).to have_content('Vídeo Muito Popular 8')
      expect(page).to have_content('video q ninguem compra')
    end
    it 'nothing' do
      admin = create(:user, :admin)

      login_as admin, scope: :user
      visit root_path
      click_on 'Relatório'

      expect(current_path).to eq(admin_report_path)
      expect(page).to have_content('Nenhum streamer com assinante')
      expect(page).to have_content('Nenhum vídeo com assinante')
      expect(page).to have_content('Nenhuma playlist com assinante')
    end
  end
end
