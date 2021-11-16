require 'rails_helper'

describe 'Administrator creates streamer profile' do
  it 'successfully' do
    admin = create(:user, :admin)

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
    admin = create(:user, :admin)

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

  it 'fails due to not being an unique name' do
    admin = create(:user, :admin)
    create(:streamer, name: 'Fulano')

    login_as admin, scope: :user
    visit root_path
    click_link 'Streamers'
    click_link 'Novo Streamer'
    within 'form' do
      fill_in 'Nome', with: 'Fulano'
      attach_file('streamer[avatar]', 'spec/fixtures/files/avatar_placeholder.png')
      click_button 'Criar Streamer'
    end

    expect(current_path).to eq(streamers_path)
    expect(page).to have_content('Nome já está em uso')
  end
end
