FactoryBot.define do
  factory :category_list do
    video_category
    trait :playlist do
      categoriable { :playlist }
    end
    # trait :video do
    #   categoriable { :video }
    # end
  end
end
