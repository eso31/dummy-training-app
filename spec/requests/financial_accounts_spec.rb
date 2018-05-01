require 'rails_helper'

RSpec.describe "FinancialAccounts", type: :request do

  before(:each) { sign_in_oauth :admin }

  describe "GET /financial_accounts" do
    it "works! (now write some real specs)" do
      get financial_accounts_path
      expect(response).to have_http_status(200)
    end
  end
end
