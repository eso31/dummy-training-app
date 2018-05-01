require 'rails_helper'

describe "RatingReasons" do

  before(:each) { user_sign_in }

  describe "GET /rating_reasons" do
    it "works! (now write some real specs)" do
      get rating_reasons_path
      expect(response).to have_http_status(200)
    end
  end
end
