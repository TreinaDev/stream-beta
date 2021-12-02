require 'rails_helper'

describe 'User accesses videos' do
  context 'and can access' do
    it 'index page' do
      user = create(:user)
      create(:user_profile, user: user)

      login_as user, scope: :user
      visit root_path
      click_link 'Vídeos'

      expect(current_path).to eq(videos_path)
      expect(page).to have_content('Vídeos')
      expect(page).to have_no_content('Novo vídeo')
    end
    it 'and can mark a video as watched' do
      user = create(:user)
      create(:user_profile, user: user)
      video = create(:video, title: 'Ótimo vídeo')

      login_as user, scope: :user
      visit root_path
      click_link 'Vídeos'
      click_on 'Ótimo vídeo'
      click_on 'Marcar como assistido'

      expect(page).to have_content('Vídeo assistido')
      expect(page).to have_content('Marcar como não assistido')
      expect(page).not_to have_content('Marcar como assistido')
      expect(current_path).to eq(video_path(video))
    end
    it 'and can mark a video as watched' do
      user = create(:user)
      create(:user_profile, user: user)
      video = create(:video, title: 'Ótimo vídeo')
      VideoHistory.create!(user: user, video: video)

      login_as user, scope: :user
      visit root_path
      click_link 'Vídeos'
      click_on 'Ótimo vídeo'
      click_on 'Marcar como não assistido'

      expect(page).not_to have_content('Vídeo assistido')
      expect(page).not_to have_content('Marcar como não assistido')
      expect(page).to have_content('Marcar como assistido')
      expect(current_path).to eq(video_path(video))
    end
  end

  context "and can't access" do
    it 'new page' do
      user = create(:user)
      create(:user_profile, user: user)

      login_as user, scope: :user
      visit new_video_path

      expect(current_path).to eq(root_path)
      expect(page).to have_content('Acesso não autorizado!')
    end
    it 'inatives videos in index' do
      user = create(:user)
      create(:user_profile, user: user)
      create(:video, title: 'video ruim', status: :inactive)

      login_as user, scope: :user
      visit videos_path

      expect(page).not_to have_content('video ruim')
    end
    it 'inatives videos' do
      user = create(:user)
      create(:user_profile, user: user)
      video = create(:video, title: 'video ruim', status: :inactive)

      login_as user, scope: :user
      visit video_path(video)

      expect(page).not_to have_content('video ruim')
      expect(current_path).not_to eq(video_path(video))
      expect(page).to have_content('Vídeo Inativo!')
    end
    it 'videos in index with inactive stream' do
      user = create(:user)
      create(:user_profile, user: user)
      streamer = create(:streamer, status: :inactive)
      create(:video, title: 'video ruim', streamer: streamer)

      login_as user, scope: :user
      visit root_path
      click_link 'Vídeos'

      expect(current_path).to eq(videos_path)
      expect(page).not_to have_content('video ruim')
      expect(page).to have_content('Nenhum vídeo encontrado')
    end
    it 'videos with inactive stream' do
      user = create(:user)
      create(:user_profile, user: user)
      video = create(:video, title: 'video ruim', status: :inactive)

      login_as user, scope: :user
      visit video_path(video)

      expect(page).not_to have_content('video ruim')
      expect(current_path).not_to eq(video_path(video))
      expect(page).to have_content('Vídeo Inativo!')
    end
  end
end
