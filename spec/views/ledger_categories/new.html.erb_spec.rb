require 'rails_helper'

RSpec.describe "ledger_categories/new", type: :view do
  before(:each) do
    assign(:ledger_category, LedgerCategory.new(
      :name => "MyString"
    ))
  end

  it "renders new ledger_category form" do
    render

    assert_select "form[action=?][method=?]", ledger_categories_path, "post" do

      assert_select "input[name=?]", "ledger_category[name]"
    end
  end
end
