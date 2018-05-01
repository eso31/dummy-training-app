require "rails_helper"

RSpec.describe AssignmentQueuesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/assignment_queues").to route_to("assignment_queues#index")
    end

    it "routes to #new" do
      expect(:get => "/assignment_queues/new").to route_to("assignment_queues#new")
    end

    it "routes to #show" do
      expect(:get => "/assignment_queues/1").to route_to("assignment_queues#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/assignment_queues/1/edit").to route_to("assignment_queues#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/assignment_queues").to route_to("assignment_queues#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/assignment_queues/1").to route_to("assignment_queues#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/assignment_queues/1").to route_to("assignment_queues#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/assignment_queues/1").to route_to("assignment_queues#destroy", :id => "1")
    end

  end
end
