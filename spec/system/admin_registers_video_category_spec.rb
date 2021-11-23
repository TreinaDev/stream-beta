require 'rails_helper'

describe 'Admin registers video category' do
  it 'successfully' do
    admin = create(:user, :admin)

    login_as admin, scope: :user
    visit admin_home_index_path
    click_on 'Categorias de Vídeos'
    fill_in 'Título', with: 'Games'
    click_on 'Cadastrar'

    expect(page).to have_content('Categoria de Vídeo criada com sucesso!')
    expect(current_path).to eq(video_category_path(VideoCategory.last.id))
  end

  it 'cannot be blank' do
    admin = create(:user, :admin)

    login_as admin, scope: :user
    visit admin_home_index_path
    click_on 'Categorias de Vídeos'
    fill_in 'Título', with: ''
    click_on 'Cadastrar'

    expect(page).to have_content('Título não pode ficar em branco')
  end

  it 'cannot be duplicates' do
    VideoCategory.create!(title: 'Games')
    admin = create(:user, :admin)

    login_as admin, scope: :user
    visit admin_home_index_path
    click_on 'Categorias de Vídeos'
    fill_in 'Título', with: 'Games'
    click_on 'Cadastrar'

    expect(page).to have_content('Título já está em uso')
  end

  it 'a subcategory successfully' do
    VideoCategory.create!(title: 'Games')
    admin = create(:user, :admin)

    login_as admin, scope: :user
    visit admin_home_index_path
    click_on 'Categorias de Vídeos'
    fill_in 'Título', with: 'RPG'
    select 'Games', from: 'Sub-categoria'
    click_on 'Cadastrar'

    expect(page).to have_content('Categoria de Vídeo criada com sucesso!')
    expect(current_path).to eq(video_category_path(VideoCategory.last.id))
    expect(page).to have_content('Games')
    expect(page).to have_content('RPG')
  end
end
