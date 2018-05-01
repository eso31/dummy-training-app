require "rails_helper"

RSpec.describe GeneralLedgersController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/general_ledgers").to route_to("general_ledgers#index")
    end

    it "routes to #new" do
      expect(:get => "/general_ledgers/new").to route_to("general_ledgers#new")
    end

    it "routes to #show" do
      expect(:get => "/general_ledgers/1").to route_to("general_ledgers#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/general_ledgers/1/edit").to route_to("general_ledgers#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/general_ledgers").to route_to("general_ledgers#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/general_ledgers/1").to route_to("general_ledgers#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/general_ledgers/1").to route_to("general_ledgers#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/general_ledgers/1").to route_to("general_ledgers#destroy", :id => "1")
    end

  end
end
