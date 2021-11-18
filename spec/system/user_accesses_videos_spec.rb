require 'rails_helper'

describe 'User accesses videos' do
  context 'and can access' do
    it 'index page' do
      user = create(:user)

      login_as user, scope: :user
      visit root_path
      click_link 'Vídeos'

      expect(current_path).to eq(videos_path)
      expect(page).to have_content('Vídeos')
      expect(page).to have_no_content('Novo vídeo')
    end
  end

  context 'and can not access' do
    it 'new page' do
      user = create(:user)

      login_as user, scope: :user
      visit new_video_path

      expect(current_path).to eq(root_path)
      expect(page).to have_content('Acesso não autorizado!')
    end
  end
end
