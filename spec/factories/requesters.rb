FactoryBot.define do
  factory :requester do
    association  :user
    association   :training_request
    status 'pending_review'

    trait :invalid do
      user nil
      training_request nil
      status nil

    end
  end
end
