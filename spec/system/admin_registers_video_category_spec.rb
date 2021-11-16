require 'rails_helper'

describe 'Admin registers video category' do
  it 'successfully' do
    john = User.create!(email: 'john@gamestream.com.br', password: '123456789')

    login_as john, scope: :user
    visit  admin_home_index
    click_on 'Cadastrar Categoria de vídeo'
    fill_in 'Categoria de Vídeo', with: 'Games'
    click_on 'Cadastrar'

    expect(page).to have_content('Categoria de Vídeo criada com sucesso!')
    expect(current_path).to eq(video_category_path(VideoCategory.last.id))
  end
end
