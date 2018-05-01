require 'rails_helper'

RSpec.describe "general_ledgers/edit", type: :view do
  before(:each) do
    @general_ledger = assign(:general_ledger, create(:general_ledger))
  end

  it "renders the edit general_ledger form" do
    render

    assert_select "form[action=?][method=?]", general_ledger_path(@general_ledger), "post" do

      assert_select "select[name=?]", "general_ledger[transaction_type]"

      assert_select "textarea[name=?]", "general_ledger[description]"

      assert_select "input[name=?]", "general_ledger[amount]"
    end
  end
end
