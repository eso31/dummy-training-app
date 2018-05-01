FactoryBot.define do
  factory :financial_account do
    name Faker::GameOfThrones.character
    status "OPEN"
    parent_account nil
  end
end
