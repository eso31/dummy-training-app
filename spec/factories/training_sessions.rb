FactoryBot.define do
  factory :training_session do
    title 'Title'
    description Faker::Lorem.paragraphs
    min_group_size 10
    max_group_size 15
    start_date Faker::Date.forward(2)
    duration_in_minutes 120
    session_type 'workshop'
    association :course
    association :class_location

    after(:build) {|training_session|
      training_session.instructors = [create(:user)]
    }

    # Create a training session with a credit
    # general ledger on it
    factory :ts_with_credit do
      after(:create) do |ts|
        ts.general_ledgers << create(:general_ledger) do |gl|
          gl.transaction_type = 'CREDIT'
        end
      end
    end

    trait :invalid do
      title nil
      description nil
    end

  end
end
