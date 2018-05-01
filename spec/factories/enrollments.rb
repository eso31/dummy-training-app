FactoryBot.define do
  factory :enrollment do
    attended true
    association :user
    association :training_session

    trait :invalid do
      attended nil
      user nil
      training_session nil
    end

  end
end