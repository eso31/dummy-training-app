require "rails_helper"

RSpec.describe TrainingSessionsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/training_sessions").to route_to("training_sessions#index")
    end

    it "routes to #new" do
      expect(:get => "/training_sessions/new").to route_to("training_sessions#new")
    end

    it "routes to #show" do
      expect(:get => "/training_sessions/1").to route_to("training_sessions#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/training_sessions/1/edit").to route_to("training_sessions#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/training_sessions").to route_to("training_sessions#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/training_sessions/1").to route_to("training_sessions#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/training_sessions/1").to route_to("training_sessions#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/training_sessions/1").to route_to("training_sessions#destroy", :id => "1")
    end

  end
end
