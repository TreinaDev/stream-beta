require 'rails_helper'

describe 'Admin edits video category' do
  it 'successfully' do
    admin = create(:user, :admin)
    create(:video_category, title: 'Games')

    login_as admin, scope: :user
    visit admin_home_index_path
    click_link 'Categorias de Vídeos'
    click_link 'Categorias'
    click_link 'Games'
    click_link 'Editar categoria'
    click_button 'Cancelar categoria'

    expect(current_path).to eq(video_categories_path)
    expect(page).to have_css('div', text: 'Categoria de Vídeo cancelada com sucesso!')
    expect(page).to_not have_content('Título: Games')
  end
end
