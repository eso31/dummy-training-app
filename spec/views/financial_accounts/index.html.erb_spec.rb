require 'rails_helper'

RSpec.describe "financial_accounts/index", type: :view do
  before(:each) do
    assign(:financial_accounts, [
      FinancialAccount.create!(
        :name => "Name",
        :status => "OPEN",
      ),
      FinancialAccount.create!(
        :name => "Name",
        :status => "OPEN",
      )
    ])

    sign_in_oauth :admin
  end

  it "renders a list of financial_accounts" do
    render
    assert_select "td", :text => "Name".to_s, :count => 2
    assert_select "td", :text => "OPEN".to_s, :count => 2
  end
end