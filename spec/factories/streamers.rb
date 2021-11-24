FactoryBot.define do
  factory :streamer do
    transient do
      username { FFaker::Internet.user_name }
    end

    name { username.split(/\.|_/).map(&:capitalize).join }
    facebook_url { "https://www.facebook.com/#{username}" }
    youtube_url { "https://www.youtube.com/c/#{username}" }
    instagram_handle { username.to_s }
    twitter_handle { username.to_s }
    avatar do
      Rack::Test::UploadedFile.new(
        File.join("#{::Rails.root}/spec/fixtures", 'files/avatar_placeholder.png'), 'image/png'
      )
    end
  end
end
