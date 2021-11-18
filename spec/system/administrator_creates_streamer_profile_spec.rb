require 'rails_helper'

describe 'Administrator creates streamer profile' do
  it 'successfully' do
    admin = create(:user, admin: true)

    login_as admin, scope: :user
    visit root_path
    click_link 'Streamers'
    click_link 'Novo Streamer'
    within 'form' do
      fill_in 'Nome', with: 'Fulano'
      attach_file('streamer[avatar]', 'spec/fixtures/files/avatar_placeholder.png')
      click_button 'Criar Streamer'
    end

    expect(current_path).to eq(streamer_path(Streamer.last))
    expect(page).to have_content('Cadastro realizado com sucesso!')
    expect(page).to have_content('Nome: Fulano')
  end

  it 'fails due to empty fields' do
    admin = create(:user, admin: true)

    login_as admin, scope: :user
    visit root_path
    click_link 'Streamers'
    click_link 'Novo Streamer'
    within 'form' do
      fill_in 'Nome', with: ''
      click_button 'Criar Streamer'
    end

    expect(current_path).to eq(streamers_path)
    expect(page).to have_content('Nome não pode ficar em branco')
    expect(page).to have_content('Avatar não pode ficar em branco')
  end

  it 'fails due to attributes not being unique' do
    admin = create(:user, admin: true)
    create(:streamer, name: 'Fulano', facebook_url: 'www.facebook.com/fulano',
                      youtube_url: 'www.youtube.com/fulano',
                      instagram_handle: 'www.instagram.com/fulano',
                      twitter_handle: 'www.twitter.com/fulano')

    login_as admin, scope: :user
    visit root_path
    click_link 'Streamers'
    click_link 'Novo Streamer'
    within 'form' do
      fill_in 'Nome', with: 'Fulano'
      attach_file('streamer[avatar]', 'spec/fixtures/files/avatar_placeholder.png')
      fill_in 'Facebook', with: 'www.facebook.com/fulano'
      fill_in 'Canal no Youtube', with: 'www.youtube.com/fulano'
      fill_in 'Instagram', with: 'www.instagram.com/fulano'
      fill_in 'Twitter', with: 'www.twitter.com/fulano'
      click_button 'Criar Streamer'
    end

    expect(current_path).to eq(streamers_path)
    expect(page).to have_content('Nome já está em uso')
    expect(page).to have_content('Facebook já está em uso')
    expect(page).to have_content('Canal no Youtube já está em uso')
    expect(page).to have_content('Instagram já está em uso')
    expect(page).to have_content('Twitter já está em uso')
  end

  it 'due to admin not be logged in' do
    create(:user, admin: true)
    create(:streamer, name: 'Fulano')

    visit root_path
    click_link 'Streamers'

    expect(page).not_to have_link 'Novo Streamer'
  end
end
