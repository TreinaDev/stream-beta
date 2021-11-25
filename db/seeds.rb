user = FactoryBot.create(:user, email: 'user@email.com', password: '123456')
FactoryBot.create(:user, email: 'admin@gamestream.com.br', password: '123456')
FactoryBot.create(:video)
FactoryBot.create(:playlist)
FactoryBot.create(:video_category)
FactoryBot.create(:streamer)
FactoryBot.create(:user_profile, user: user)

p 'Banco de dados atualizado com sucesso :)'
