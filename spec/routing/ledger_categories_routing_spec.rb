require "rails_helper"

RSpec.describe LedgerCategoriesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/ledger_categories").to route_to("ledger_categories#index")
    end

    it "routes to #new" do
      expect(:get => "/ledger_categories/new").to route_to("ledger_categories#new")
    end

    it "routes to #show" do
      expect(:get => "/ledger_categories/1").to route_to("ledger_categories#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/ledger_categories/1/edit").to route_to("ledger_categories#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/ledger_categories").to route_to("ledger_categories#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/ledger_categories/1").to route_to("ledger_categories#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/ledger_categories/1").to route_to("ledger_categories#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/ledger_categories/1").to route_to("ledger_categories#destroy", :id => "1")
    end

  end
end
