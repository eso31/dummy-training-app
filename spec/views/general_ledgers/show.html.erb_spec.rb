require 'rails_helper'

RSpec.describe "general_ledgers/show", type: :view do
  before(:each) do
    @general_ledger = assign(:general_ledger, create(:general_ledger))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(@general_ledger.description)
    expect(rendered).to match(@general_ledger.transaction_type)
  end
end
