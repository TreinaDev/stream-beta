require 'rails_helper'

describe 'User purchases video' do
  context 'when authenticated' do
    it 'successfully' do
      user = create(:user)
      create(:user_profile, user: user)
      video = create(:video, :allow_purchase, :random_token, title: 'Melhores jogadas da semana')

      login_as user, scope: :user
      visit root_path
      click_link 'Vídeos'
      click_link 'Melhores jogadas da semana'
      click_link 'Adquirir Vídeo'
      click_button 'Confirmar compra'

      purchase = user.user_videos.find_by(video: video)
      expect(purchase).to be_approved
      expect(current_path).to eq(video_path(video))
      expect(page).to have_css('div', text: 'Compra realizada com sucesso!')
      expect(page).to have_content('Você tem acesso vitalício a esse vídeo!')
      expect(page).to have_no_content('Valor')
      expect(page).to have_no_link('Adquirir Vídeo')
    end

    it 'but fails due to payment not authorized' do
      user = create(:user)
      create(:user_profile, user: user)
      video = create(:video, :allow_purchase, :random_token, title: 'Melhores jogadas da semana')
      allow_any_instance_of(UserVideo).to receive(:set_status).and_return(:rejected)

      login_as user, scope: :user
      visit root_path
      click_link 'Vídeos'
      click_link 'Melhores jogadas da semana'
      click_link 'Adquirir Vídeo'
      click_button 'Confirmar compra'

      purchase = user.user_videos.find_by(video: video)
      expect(purchase).to be_rejected
      expect(current_path).to eq(video_path(video))
      expect(page).to have_css('div', text: 'Pagamento reprovado')
      expect(page).to have_no_content('Você tem acesso vitalício a esse vídeo!')
      expect(page).to have_content('Valor')
      expect(page).to have_link('Adquirir Vídeo')
      expect(user.videos.count).to eq 1
    end

    it 'and the payment status is pending' do
      user = create(:user)
      create(:user_profile, user: user)
      video = create(:video, :allow_purchase, :random_token, title: 'Melhores jogadas da semana')
      allow_any_instance_of(UserVideo).to receive(:set_status).and_return(:pending)

      login_as user, scope: :user
      visit root_path
      click_link 'Vídeos'
      click_link 'Melhores jogadas da semana'
      click_link 'Adquirir Vídeo'
      click_button 'Confirmar compra'

      purchase = user.user_videos.find_by(video: video)
      expect(purchase).to be_pending
      expect(current_path).to eq(video_path(video))
      expect(page).to have_css('div', text: 'Pagamento em análise')
      expect(page).to have_no_content('Você tem acesso vitalício a esse vídeo!')
      expect(page).to have_no_content('Valor')
      expect(page).to have_no_link('Adquirir Vídeo')
    end
  end

  context 'when not authenticated' do
    it 'trying to purchase a video will redirect to sign_in screen' do
      create(:video, :allow_purchase, :random_token, title: 'Melhores jogadas da semana')

      visit root_path
      click_link 'Vídeos'
      click_link 'Melhores jogadas da semana'
      click_link 'Adquirir Vídeo'

      expect(current_path).to eq(new_user_session_path)
    end
  end
end
