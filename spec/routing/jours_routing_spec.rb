require "rails_helper"

RSpec.describe JoursController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/jours").to route_to("jours#index")
    end

    it "routes to #show" do
      expect(:get => "/jours/1").to route_to("jours#show", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/jours").to route_to("jours#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/jours/1").to route_to("jours#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/jours/1").to route_to("jours#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/jours/1").to route_to("jours#destroy", :id => "1")
    end
  end
end
