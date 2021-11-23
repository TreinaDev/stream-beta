FactoryBot.create(:user, email: 'joao@gamestream.com.br', password: '123456')
FactoryBot.create(:user, email: 'maria@gamestream.com.br', password: '123456')
joana  = FactoryBot.create(:user, email: 'joana@email.com', password: '123456')
marcos = FactoryBot.create(:user, email: 'marcos@email.com', password: '123456')

FactoryBot.create(:user_profile, user: joana)
FactoryBot.create(:user_profile, user: marcos)

(0..3).each do |i|
  FactoryBot.create(:video_category)
  FactoryBot.create(:video)
  FactoryBot.create(:subscription_plan)

end
