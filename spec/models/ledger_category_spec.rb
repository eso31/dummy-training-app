require 'rails_helper'

RSpec.describe LedgerCategory, type: :model do

  subject { create :ledger_category }

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'should validate presence of attributes' do
    should validate_presence_of(:name)
  end
end