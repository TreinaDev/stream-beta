FactoryBot.define do
  factory :streamer do
    sequence(:name) { |n| "Streamer #{n}" }

    avatar do
      Rack::Test::UploadedFile.new(
        File.join("#{::Rails.root}/spec/fixtures", 'files/avatar_placeholder.png'), 'image/png'
      )
    end
  end
end
