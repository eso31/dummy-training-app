class FinancialAccount < ApplicationRecord
  audited
  include Searchable

  enum status: { 'OPEN': 'OPEN', 'CLOSE': 'CLOSE' }
  has_many :general_ledgers

  belongs_to :parent_account, class_name: 'FinancialAccount', required: false

  validates :name, presence: true
  validates :status, presence: true, inclusion: {in: statuses.keys, message: 'The value: %{value} is not a valid status'}

  def financial_planned ledgers
    planned_ledgers = ledgers.group_by(&:transaction_type)['PLANNED']
    if !planned_ledgers.nil?
      planned_ledgers = planned_ledgers.select { |ledger| ledger.transaction_date ? ledger.transaction_date >= Time.now : nil }
      sum_ledgers planned_ledgers
    else
      Money.new(0)
    end
  end

  def financial_available ledgers
    filter_ledgers(ledgers, 'DEBIT') - filter_ledgers(ledgers, 'CREDIT')
  end

  def financial_avaiblable_after_planned ledgers
    financial_available(ledgers) - financial_planned(ledgers)
  end

  def monthly_general_ledgers year, month, type
    filter_ledgers(monthly_ledgers(year, month), type)
  end

  def filter_ledgers ledgers, type
    sum_ledgers((!ledgers.nil? ? ledgers.group_by(&:transaction_type)[type] || [] : []))
  end

  def monthly_ledgers year, month
    general_ledgers.group_by{ |w| [ w.transaction_date.month,  w.transaction_date.year]}[[month, year]]
  end

  private

  def sum_ledgers filtered_ledgers
    Money.new(filtered_ledgers.sum(&:amount) * 100)
  end
end
