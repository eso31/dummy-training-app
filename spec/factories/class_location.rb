require 'faker'

FactoryBot.define do
  factory :class_location do
    name {Faker::ElderScrolls.region}
    email {Faker::Internet.unique.email}
    timezone {Faker::Compass.direction}

    trait :invalid do
      name nil
      email nil
      timezone nil
    end


  end
end
