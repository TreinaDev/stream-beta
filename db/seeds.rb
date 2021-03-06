# Users
user = FactoryBot.create(:user, email: 'user@email.com', password: '123456')
FactoryBot.create(:user_profile, user: user)
FactoryBot.create(:payment_method, user: user)

FactoryBot.create(:user, email: 'admin@gamestream.com.br', password: '123456')

# Streamers
streamer1 = FactoryBot.create(:streamer)
sleep(1)
streamer2 = FactoryBot.create(:streamer)
sleep(1)
streamer3 = FactoryBot.create(:streamer)

# Video Categories
video_category1 = FactoryBot.create(:video_category)
video_category2 = FactoryBot.create(:video_category)
video_category3 = FactoryBot.create(:video_category, parent: video_category2)

# Videos
FactoryBot.create(:video, streamer: streamer1)
FactoryBot.create(:video, streamer: streamer2)
FactoryBot.create(:video, streamer: streamer3)

FactoryBot.create(:video, :allow_purchase, streamer: streamer1)
FactoryBot.create(:video, :allow_purchase, streamer: streamer2)

# Playlists
FactoryBot.create(:playlist)
FactoryBot.create(:playlist)
FactoryBot.create(:playlist)

FactoryBot.create(:subscription_plan, :streamer)
FactoryBot.create(:user_subscription_plan, user: user, status: 'approved')
p 'Banco de dados atualizado com sucesso :)'
