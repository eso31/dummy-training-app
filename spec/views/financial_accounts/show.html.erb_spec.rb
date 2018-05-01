require 'rails_helper'

RSpec.describe "financial_accounts/show", type: :view do
  before(:each) do
    @financial_account = assign(:financial_account, create(:financial_account))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Status/)
  end
end
