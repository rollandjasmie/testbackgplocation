require "rails_helper"

RSpec.describe DateSaisonsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/date_saisons").to route_to("date_saisons#index")
    end

    it "routes to #show" do
      expect(:get => "/date_saisons/1").to route_to("date_saisons#show", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/date_saisons").to route_to("date_saisons#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/date_saisons/1").to route_to("date_saisons#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/date_saisons/1").to route_to("date_saisons#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/date_saisons/1").to route_to("date_saisons#destroy", :id => "1")
    end
  end
end
