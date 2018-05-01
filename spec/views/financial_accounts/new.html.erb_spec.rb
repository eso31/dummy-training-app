require 'rails_helper'

RSpec.describe "financial_accounts/new", type: :view do
  before(:each) do
    assign(:financial_account, FinancialAccount.new(
      :name => "MyString",
      :status => "OPEN",
      :parent_account => nil
    ))
  end

  it "renders new financial_account form" do
    render

    assert_select "form[action=?][method=?]", financial_accounts_path, "post" do

      assert_select "input[name=?]", "financial_account[name]"

      assert_select "select#financial_account_status"

    end
  end
end
