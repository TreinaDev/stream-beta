require 'rails_helper'

describe 'User purchases video' do
  let(:header) do
    { 'Content-Type' => 'application/json', 'company_token' => Rails.configuration.api_pagapaga[:company_token] }
  end

  context 'when authenticated' do
    it 'successfully' do
      user = create(:user)
      create(:user_profile, user: user)
      video = create(:video, :allow_purchase, title: 'Melhores jogadas da semana')
      payment_method = create(:payment_method, user: user)

      payment_methods_response = File.read(Rails.root.join('spec/support/apis/available_payment_methods/all.json'))
      fake_response_apm = instance_double(Faraday::Response, status: 200, body: payment_methods_response)
      allow(Faraday).to receive(:get).with('http://localhost:4000/api/v1/available_payment_methods/', {}, header)
                                     .and_return(fake_response_apm)

      user_video = { single_product_payment: { payment_method_token: payment_method.token,
                                               product_token: video.token } }
      fake_response = { payment_status: 'approved', receipt_token: 'h7d6yy79YO' }
      allow(ApiPagapaga).to receive(:post).with('single_product_payments', user_video.to_json).and_return(fake_response)

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
      video = create(:video, :allow_purchase, title: 'Melhores jogadas da semana')
      payment_method = create(:payment_method, user: user)

      payment_methods_response = File.read(Rails.root.join('spec/support/apis/available_payment_methods/all.json'))
      fake_response_apm = instance_double(Faraday::Response, status: 200, body: payment_methods_response)
      allow(Faraday).to receive(:get).with('http://localhost:4000/api/v1/available_payment_methods/', {}, header)
                                     .and_return(fake_response_apm)

      user_video = { single_product_payment: { payment_method_token: payment_method.token,
                                               product_token: video.token } }
      fake_response = { payment_status: 'rejected', receipt_token: '' }
      allow(ApiPagapaga).to receive(:post).with('single_product_payments', user_video.to_json).and_return(fake_response)

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

    it 'but fails due to having no payment methods available' do
      user = create(:user)
      create(:user_profile, user: user)
      create(:video, :allow_purchase, title: 'Melhores jogadas da semana')

      fake_response_apm = instance_double(Faraday::Response, status: 200, body: [])
      allow(Faraday).to receive(:get).with('http://localhost:4000/api/v1/available_payment_methods/', {}, header)
                                     .and_return(fake_response_apm)

      login_as user, scope: :user
      visit root_path
      click_link 'Vídeos'
      click_link 'Melhores jogadas da semana'
      click_link 'Adquirir Vídeo'

      expect(page).to have_css('div', text: 'Não há formas de pagamento habilitadas')
      expect(page).to have_no_content('Você tem acesso vitalício a esse vídeo!')
      expect(page).to have_content('Valor')
      expect(page).to have_no_button('Confirmar compra')
      expect(user.videos.count).to eq 0
    end

    it 'and the payment status is pending' do
      user = create(:user)
      create(:user_profile, user: user)
      video = create(:video, :allow_purchase, title: 'Melhores jogadas da semana')
      payment_method = create(:payment_method, user: user)

      payment_methods_response = File.read(Rails.root.join('spec/support/apis/available_payment_methods/all.json'))
      fake_response_apm = instance_double(Faraday::Response, status: 200, body: payment_methods_response)
      allow(Faraday).to receive(:get).with('http://localhost:4000/api/v1/available_payment_methods/', {}, header)
                                     .and_return(fake_response_apm)

      user_video = { single_product_payment: { payment_method_token: payment_method.token,
                                               product_token: video.token } }
      fake_response = { payment_status: 'pending', receipt_token: '' }
      allow(ApiPagapaga).to receive(:post).with('single_product_payments', user_video.to_json).and_return(fake_response)

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
      create(:video, :allow_purchase, title: 'Melhores jogadas da semana')

      visit root_path
      click_link 'Vídeos'
      click_link 'Melhores jogadas da semana'
      click_link 'Adquirir Vídeo'

      expect(current_path).to eq(new_user_session_path)
    end
  end
end
