require 'rails_helper'

describe 'Admin registers video category' do
  it 'successfully' do
    admin = create(:user, :admin)

    login_as admin, scope: :user
    visit admin_home_index_path
    click_link 'Categorias de Vídeos'
    within 'form' do
      fill_in 'Título', with: 'Games'
      click_button 'Criar Categoria de Vídeo'
    end

    expect(current_path).to eq(video_category_path(VideoCategory.last))
    expect(page).to have_css('div', text: 'Categoria de Vídeo criada com sucesso!')
    expect(page).to have_no_content('Sub-categoria')
    expect(page).to have_content('Título: Games')
  end

  it 'cannot be blank' do
    admin = create(:user, :admin)

    login_as admin, scope: :user
    visit admin_home_index_path
    click_link 'Categorias de Vídeos'
    within 'form' do
      fill_in 'Título', with: ''
      click_button 'Criar Categoria de Vídeo'
    end

    expect(page).to have_css('div', text: 'Título não pode ficar em branco')
  end

  it 'cannot be duplicated' do
    create(:video_category, title: 'Games')
    admin = create(:user, :admin)

    login_as admin, scope: :user
    visit admin_home_index_path
    click_link 'Categorias de Vídeos'
    within 'form' do
      fill_in 'Título', with: 'Games'
      click_button 'Criar Categoria de Vídeo'
    end

    expect(page).to have_css('div', text: 'Título já está em uso')
  end

  it 'with a subcategory successfully' do
    create(:video_category, title: 'Games')
    admin = create(:user, :admin)

    login_as admin, scope: :user
    visit admin_home_index_path
    click_link 'Categorias de Vídeos'
    within 'form' do
      fill_in 'Título', with: 'RPG'
      select 'Games', from: 'Sub-categoria'
      click_button 'Criar Categoria de Vídeo'
    end

    expect(current_path).to eq(video_category_path(VideoCategory.last.id))
    expect(page).to have_css('div', text: 'Categoria de Vídeo criada com sucesso!')
    expect(page).to have_content('Sub-categoria de: Games')
    expect(page).to have_content('Título: RPG')
  end
end
