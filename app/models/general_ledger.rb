# frozen_string_literal: true

# General Ledger
class GeneralLedger < ApplicationRecord
  audited

  include Searchable

  enum type: {
    debit: 'DEBIT',
    credit: 'CREDIT',
    balance: 'BALANCE',
    planned: 'PLANNED',
    requested: 'REQUESTED'
  }

  belongs_to :financial_account
  belongs_to :training_request, class_name: 'TrainingRequest', required: false
  belongs_to :training_session, class_name: 'TrainingSession', required: false
  belongs_to :ledger_category

  validates :transaction_type, presence: true, inclusion: {
    in: types.values,
    message: 'The value: %{value} is not a valid type'
  }

  validates :description, presence: true
  validates :amount, presence: true

  def amount_currency
    Money.new(amount * 100)
  end
end
