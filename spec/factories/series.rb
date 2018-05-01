
FactoryBot.define do
  factory :series do
    name {Faker::Color.color_name}
    description {Faker::Lorem.paragraph}
    trait :invalid do
      name nil
      description nil
    end

  end
end