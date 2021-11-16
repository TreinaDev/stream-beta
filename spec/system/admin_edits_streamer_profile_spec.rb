require 'rails_helper'

describe 'Administrator edit streamer profile' do
  it 'successfully changes streamer name' do
    admin = create(:user, :admin)
    streamer = create(:streamer, name: 'Fulano')

    login_as admin, scope: :user
    visit root_path
    click_link 'Streamers'
    click_link 'Fulano'
    click_link 'Editar Streamer'
    within 'form' do
      fill_in 'Nome', with: 'Sicrano'
      click_button 'Editar Streamer'
    end

    expect(current_path).to eq streamer_path(Streamer.last)
    expect(page).to have_content('Cadastro editado com sucesso!')
    expect(page).to have_content('Nome: Sicrano')
  end
end