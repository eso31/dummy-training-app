# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    password 'ultra-secret'
    password_confirmation 'ultra-secret'
    email { Faker::Internet.unique.email }
    first_name { Faker::DragonBall.character }
    last_name { Faker::DragonBall.character }
    notification false
    vegetarian true

    factory :workshops_admin do
      after(:create) do |u|
        u.add_role :workshops_admin
      end
    end

    factory :training_admin do
      after(:create) do |u|
        u.add_role :training_admin
      end
    end

    factory :admin do
      after(:create) do |u|
        u.add_role :admin
      end
    end

    factory :financial_admin do
      after(:create) do |u|
        u.add_role :financial_admin
      end
    end

    trait :invalid do
      email nil
      first_name '  '
      last_name '  '
    end
  end
end