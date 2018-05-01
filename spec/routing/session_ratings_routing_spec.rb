require "rails_helper"

RSpec.describe SessionRatingsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/session_ratings").to route_to("session_ratings#index")
    end

    it "routes to #new" do
      expect(:get => "/session_ratings/new").to route_to("session_ratings#new")
    end

    it "routes to #show" do
      expect(:get => "/session_ratings/1").to route_to("session_ratings#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/session_ratings/1/edit").to route_to("session_ratings#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/session_ratings").to route_to("session_ratings#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/session_ratings/1").to route_to("session_ratings#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/session_ratings/1").to route_to("session_ratings#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/session_ratings/1").to route_to("session_ratings#destroy", :id => "1")
    end

  end
end
