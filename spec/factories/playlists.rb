FactoryBot.define do
  factory :playlist do
    title { FFaker::Game.category }
    description { FFaker::LoremBR.paragraph }

    playlist_cover do
      Rack::Test::UploadedFile.new(
        File.join("#{::Rails.root}/spec/fixtures", 'files/avatar_placeholder.png'), 'image/png'
      )
    end
  end
end
