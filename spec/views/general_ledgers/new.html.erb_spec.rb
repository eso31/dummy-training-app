require 'rails_helper'

RSpec.describe "general_ledgers/new", type: :view do

  let(:general_ledger) { build(:general_ledger) }
  before(:each) do
    assign(:general_ledger, general_ledger)
  end

  it "renders new general_ledger form" do
    render

    assert_select "form[action=?][method=?]", general_ledgers_path, "post" do

      assert_select 'select[name=?]', 'general_ledger[transaction_type]'

      assert_select "textarea[name=?]", "general_ledger[description]"

      assert_select "input[name=?]", "general_ledger[amount]"
    end
  end
end
