require "rails_helper"

RSpec.describe EnrollmentsController, type: :routing do

  let(:training_session) {create(:training_session)}

  describe "routing" do

    it "routes to #create" do
      expect(:post => "/training_sessions/1/enrollments").to route_to("enrollments#create", training_session_id: "1")
    end

    it "routes to #update via PUT" do
      expect(:put => "/training_sessions/1/enrollments/1").to route_to("enrollments#update", :id => "1", training_session_id: "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/training_sessions/1/enrollments/1").to route_to("enrollments#update", :id => "1", training_session_id: "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/training_sessions/1/enrollments/1").to route_to("enrollments#destroy", :id => "1", training_session_id: "1")
    end

  end
end
