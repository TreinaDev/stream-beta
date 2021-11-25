require 'rails_helper'

describe 'Admin links category and sub-category to playlist' do
  it 'successfully' do
    admin = create(:user, :admin)
    create(:video_category, title: 'Jogos online')
    create(:video_category, title: 'Jogos offline')
    login_as admin, scope: :user
    visit root_path

    click_link 'Playlists'
    click_link 'Nova Playlist'
    within 'form' do
      fill_in 'Título', with: 'As melhores jogadas'
      fill_in 'Descrição', with: 'Playlist com as melhores jogadas dos streamers participantes'
      attach_file('playlist[playli
        st_cover]', 'spec/fixtures/files/avatar_placeholder.png')
      select 'Jogos online', from: 'Categoria de Vídeo/Playlist'
      click_button 'Criar Playlist'
    end

    expect(current_path).to eq(playlist_path(Playlist.last))
    expect(page).to have_css('div', text: 'Playlist criada com sucesso!')
    expect(page).to have_content('Título: As melhores jogadas')
    expect(page).to have_content('Descrição: Playlist com as melhores jogadas dos streamers participantes')
    expect(page).to have_content('Categoria: Jogos online')
    expect(page).not_to have_content('Categoria: Jogos offline')
  end
end
