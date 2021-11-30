require 'rails_helper'


describe 'Admin edits video category' do
  it 'successfully' do
    admin = create(:user, :admin)
    create(:video_category, title: 'Games')

    login_as admin, scope: :user
    visit admin_home_index_path
    click_link 'Categorias de Vídeos'
    click_link 'Ver todas categorias'
    click_link 'Games'
    click_link 'Editar categoria'
    within 'form' do
      fill_in 'Título', with: 'Games editado'
      click_button 'Atualizar Categoria de Vídeo'
    end

    expect(current_path).to eq(video_category_path(VideoCategory.last))
    expect(page).to have_css('div', text: 'Categoria de Vídeo editada com sucesso!')
    expect(page).to have_content('Título: Games editado')
  end
end
