FactoryBot.define do
  factory :instructor do
    association :user
    association :training_session


  end
end
