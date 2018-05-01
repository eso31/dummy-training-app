FactoryBot.define do
  factory :course do

    title "Tittle"
    description Faker::GameOfThrones.city
    duration_in_minutes 1
    min_group_size 1
    max_group_size 2

    association :taught_by_user, factory: :user
    association :series, factory: :series

    trait :invalid do
      taught_by_user nil
      serie nil
      duration_in_minutes nil
      min_group_size 1
      max_group_size 1
    end
  end
end
