require 'rails_helper'

describe 'Admin creates promotion ticket' do
  it 'successfully' do
    admin = create(:user, :admin)

    login_as admin, scope: :user
    visit root_path
    click_link 'Promoções'
    click_link 'Novo Ticket de Promoção'
    within 'form' do
      fill_in 'Título', with: 'Queima de estoque'
      fill_in 'Desconto percentual', with: '20'
      fill_in 'Desconto bruto máximo', with: '30'
      fill_in 'Limite máximo de uso', with: '2'
      fill_in 'Data inicial', with: Date.current
      fill_in 'Data final', with: 15.days.from_now
      click_on 'Criar Ticket de promoção'
    end

    expect(page).to have_content('Ticket de promoção criado com sucesso!')
    expect(current_path).to eq(promotion_tickets_path)
    expect(page).to have_content('Título: Queima de estoque')
    expect(page).to have_content("Data inicial: #{I18n.l(Date.current)}")
    expect(page).to have_content("Data final: #{I18n.l(15.days.from_now.to_date)}")
    expect(page).to have_content('Desconto percentual: 20%')
    expect(page).to have_content('Desconto bruto máximo: R$ 30,00')
  end

  it 'cannot be blank' do
    admin = create(:user, :admin)

    login_as admin, scope: :user
    visit root_path
    click_link 'Promoções'
    click_link 'Novo Ticket de Promoção'
    within 'form' do
      click_on 'Criar Ticket de promoção'
    end

    expect(page).to have_content('Título não pode ficar em branco')
    expect(page).to have_content('Data inicial não pode ficar em branco')
    expect(page).to have_content('Data final não pode ficar em branco')
    expect(page).to have_content('Desconto percentual não pode ficar em branco')
    expect(page).to have_content('Limite máximo de uso não pode ficar em branco')
    expect(page).to have_content('Desconto bruto máximo não pode ficar em branco')
  end
end
