require "rails_helper"

RSpec.describe JourferiersController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/jourferiers").to route_to("jourferiers#index")
    end

    it "routes to #show" do
      expect(:get => "/jourferiers/1").to route_to("jourferiers#show", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/jourferiers").to route_to("jourferiers#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/jourferiers/1").to route_to("jourferiers#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/jourferiers/1").to route_to("jourferiers#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/jourferiers/1").to route_to("jourferiers#destroy", :id => "1")
    end
  end
end
