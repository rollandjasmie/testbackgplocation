require "rails_helper"

RSpec.describe SaisonsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/saisons").to route_to("saisons#index")
    end

    it "routes to #show" do
      expect(:get => "/saisons/1").to route_to("saisons#show", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/saisons").to route_to("saisons#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/saisons/1").to route_to("saisons#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/saisons/1").to route_to("saisons#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/saisons/1").to route_to("saisons#destroy", :id => "1")
    end
  end
end
