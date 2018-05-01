require "rails_helper"

RSpec.describe TrainingRequestPollsController, type: :routing do

  let(:training_request) {create(:training_request)}

  describe "routing" do

    it "routes to #new" do
      expect(:get => "training_requests/1/training_request_polls/new").to route_to("training_request_polls#new", training_request_id: "1")
    end


    it "routes to #edit" do
      expect(:get => "training_requests/1/training_request_polls/1/edit").to route_to("training_request_polls#edit", :id => "1", training_request_id: "1")
    end

    it "routes to #create" do
      expect(:post => "training_requests/1/training_request_polls").to route_to("training_request_polls#create", training_request_id: "1")
    end

    it "routes to #update via PUT" do
      expect(:put => "training_requests/1/training_request_polls/1").to route_to("training_request_polls#update", :id => "1", training_request_id: "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "training_requests/1/training_request_polls/1").to route_to("training_request_polls#update", :id => "1", training_request_id: "1")
    end

    it "routes to #destroy" do
      expect(:delete => "training_requests/1/training_request_polls/1").to route_to("training_request_polls#destroy", :id => "1", training_request_id: "1")
    end

  end
end
