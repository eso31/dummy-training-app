FactoryBot.define do
  factory :general_ledger do
    transaction_type "DEBIT"
    description "Text"
    transaction_date "2017-11-27 10:02:42"
    amount 15.50
    association :financial_account
    association :ledger_category
    association :training_request
    association :training_session
  end
end
