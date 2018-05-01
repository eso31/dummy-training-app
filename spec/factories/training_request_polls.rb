FactoryBot.define do
  factory :training_request_poll do
    vote 'approved'
    comment 'MyText'

    association :user
    association :training_request

    trait :invalid do
      vote nil
    end
  end
end
