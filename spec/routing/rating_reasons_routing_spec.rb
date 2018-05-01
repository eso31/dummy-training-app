require "rails_helper"

RSpec.describe RatingReasonsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/rating_reasons").to route_to("rating_reasons#index")
    end

    it "routes to #new" do
      expect(:get => "/rating_reasons/new").to route_to("rating_reasons#new")
    end

    it "routes to #show" do
      expect(:get => "/rating_reasons/1").to route_to("rating_reasons#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/rating_reasons/1/edit").to route_to("rating_reasons#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/rating_reasons").to route_to("rating_reasons#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/rating_reasons/1").to route_to("rating_reasons#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/rating_reasons/1").to route_to("rating_reasons#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/rating_reasons/1").to route_to("rating_reasons#destroy", :id => "1")
    end

  end
end
