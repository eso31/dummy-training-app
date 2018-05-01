require 'rails_helper'

describe "AssignmentQueues" do

  before(:each) { sign_in_oauth :admin }

  describe "GET /assignment_queues" do
    it "works! (now write some real specs)" do
      get assignment_queues_path
      expect(response).to have_http_status(200)
    end
  end
end
