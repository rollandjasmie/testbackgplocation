require "rails_helper"

RSpec.describe BaseTarifsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/base_tarifs").to route_to("base_tarifs#index")
    end

    it "routes to #show" do
      expect(:get => "/base_tarifs/1").to route_to("base_tarifs#show", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/base_tarifs").to route_to("base_tarifs#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/base_tarifs/1").to route_to("base_tarifs#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/base_tarifs/1").to route_to("base_tarifs#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/base_tarifs/1").to route_to("base_tarifs#destroy", :id => "1")
    end
  end
end
