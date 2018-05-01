FactoryBot.define do
  factory :assignment_queue do
    assignment_order 1
    status "ACTIVE"
    association :user, factory: :user
    association :training_request, factory: :training_request

    trait :invalid do
      assignment_order nil
      status nil
      user nil
      training_request nil
    end
  end
end
