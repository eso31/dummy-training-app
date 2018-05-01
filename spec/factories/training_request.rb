require 'faker'

FactoryBot.define do
  factory :training_request do
    name {  'Course at '+ Faker::Educator.university + ' for '+ Faker::Demographic.race}
    description Faker::Lorem.paragraph
    location Faker::Address.full_address
    start_date Faker::Date.between(Date.today, Date.today + 5)
    end_date Faker::Date.between(Date.today+6, Date.today + 10)
    reference_file Faker::Internet.url
    duration_in_minutes 400

    status :pending_review

    association :assigned_to_user, factory: :training_admin
    association :requested_by_user, factory: :user

    trait :in_the_future do
      start_date {2.days.from_now}
    end


    trait :in_the_past do
      start_date {2.days.ago}
    end

    trait :invalid do
      name nil
    end

  end
end