require 'rails_helper'

RSpec.describe "financial_accounts/edit", type: :view do
  before(:each) do
    @financial_account = assign(:financial_account, create(:financial_account))
  end

  it "renders the edit financial_account form" do
    render

    assert_select "form[action=?][method=?]", financial_account_path(@financial_account), "post" do

      assert_select "input[name=?]", "financial_account[name]"

      assert_select "select#financial_account_status"

    end
  end
end
