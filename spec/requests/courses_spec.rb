require 'rails_helper'

describe "Courses" do

  before(:each) { sign_in_oauth :admin }

  describe "GET /courses" do
    it "works! (now write some real specs)" do
      get courses_path
      expect(response).to have_http_status(200)
    end
  end
end
