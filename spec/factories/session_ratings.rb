FactoryBot.define do
  factory :session_rating do
    rating 5
    user_type "STUDENT"
    comment Faker::Lorem.paragraph
    association :enrollment
    association :user

    trait :invalid do
      rating nil
      user_type nil
      enrollment nil
      user nil
    end
  end
end
