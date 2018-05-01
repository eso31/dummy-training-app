require 'rails_helper'

RSpec.describe GeneralLedger, type: :model do
  subject { create :general_ledger }

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'should validate presence of attributes' do
    should validate_presence_of(:transaction_type)
    should validate_presence_of(:description)
    should validate_presence_of(:amount)
  end

  describe "Associations" do
    it "belongs to user" do
      should belong_to(:financial_account)
    end

    it "belongs to training session" do
      should belong_to(:training_request)
    end

    it "belongs to training session" do
      should belong_to(:training_session)
    end

    it "belongs to training session" do
      should belong_to(:ledger_category)
    end
  end
end
