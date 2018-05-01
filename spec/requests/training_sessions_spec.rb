require 'rails_helper'

describe "TrainingSessions" do

  before(:each) { user_sign_in }

  describe "GET /training_sessions" do
    it "works! (now write some real specs)" do
      get training_sessions_path
      expect(response).to have_http_status(200)
    end
  end
end
