require 'rails_helper'

RSpec.describe "ledger_categories/show", type: :view do
  before(:each) do
    @ledger_category = assign(:ledger_category, LedgerCategory.create!(
      :name => "Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
  end
end
