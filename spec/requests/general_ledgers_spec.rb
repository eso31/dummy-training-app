require 'rails_helper'

RSpec.describe "GeneralLedgers", type: :request do

  before(:each) { sign_in_oauth :admin }

  describe "GET /general_ledgers" do
    it "works! (now write some real specs)" do
      get general_ledgers_path
      expect(response).to have_http_status(200)
    end
  end
end
