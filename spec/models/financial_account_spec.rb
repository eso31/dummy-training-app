require 'rails_helper'

RSpec.describe FinancialAccount do
  subject { create :financial_account }

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'validates presence of attributes' do
    should validate_presence_of(:name)
    should validate_presence_of(:status)
  end

    it 'sums all the amounts of the debit general ledgers of the subject' do
      create(:general_ledger, financial_account: subject, amount: 200, transaction_type: "DEBIT")
      create(:general_ledger, financial_account: subject, amount: 250, transaction_type: "DEBIT")
      expect(subject.filter_ledgers(subject.general_ledgers, "DEBIT")).to eql(Money.new(45000))
    end

  it 'sums all the amounts of the credit general ledgers of the subject' do
    create(:general_ledger, financial_account: subject, amount: -200, transaction_type: "CREDIT")
    create(:general_ledger, financial_account: subject, amount: -250, transaction_type: "CREDIT")
    expect(subject.filter_ledgers(subject.general_ledgers, "CREDIT")).to eql(Money.new(-45000))
  end

  it 'sums all the amounts of the planned general ledgers of the subject that have a transaction date from today and foward' do
    create(:general_ledger, financial_account: subject, amount: 450, transaction_type: "PLANNED", transaction_date: Date.tomorrow)
    create(:general_ledger, financial_account: subject, amount: 200, transaction_type: "PLANNED", transaction_date: Date.yesterday)
    expect(subject.financial_planned(subject.general_ledgers)).to eql(Money.new(45000))
  end

  it 'gets the financial amount available from substracting credit general ledgers from debit general ledgers' do
    create(:general_ledger, financial_account: subject, amount: 450, transaction_type: "DEBIT")
    create(:general_ledger, financial_account: subject, amount: 200, transaction_type: "CREDIT")
    expect(subject.financial_available(subject.general_ledgers)).to eql(Money.new(25000))
  end

  it 'gets the financial amount available from substracting planned general ledgers from the result of financial available amount' do
    create(:general_ledger, financial_account: subject, amount: 450, transaction_type: "DEBIT")
    create(:general_ledger, financial_account: subject, amount: 200, transaction_type: "CREDIT")
    create(:general_ledger, financial_account: subject, amount: 200, transaction_type: "PLANNED", transaction_date: Date.tomorrow)
    expect(subject.financial_avaiblable_after_planned(subject.general_ledgers)).to eql(Money.new(5000))
  end
end