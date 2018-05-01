FactoryBot.define do
  factory :rating_reason do
    description  "Description"
    rating_type 'student'

    trait :invalid do
      description nil
      rating_type nil
    end

  end
end
