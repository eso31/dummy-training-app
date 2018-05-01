# frozen_string_literal: true

require 'faker'

FactoryBot.define do
  factory :audit, class: Audited::Audit do
    auditable_id Faker::Number.number(3)
    auditable_type Faker::App.name
    action 'delete'
    audited_changes { {} }
  end
end