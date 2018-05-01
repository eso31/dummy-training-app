require 'rails_helper'

RSpec.describe "ledger_categories/edit", type: :view do
  before(:each) do
    @ledger_category = assign(:ledger_category, LedgerCategory.create!(
      :name => "MyString"
    ))
  end

  it "renders the edit ledger_category form" do
    render

    assert_select "form[action=?][method=?]", ledger_category_path(@ledger_category), "post" do

      assert_select "input[name=?]", "ledger_category[name]"
    end
  end
end
