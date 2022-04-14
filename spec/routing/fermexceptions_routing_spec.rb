require "rails_helper"

RSpec.describe FermexceptionsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/fermexceptions").to route_to("fermexceptions#index")
    end

    it "routes to #show" do
      expect(:get => "/fermexceptions/1").to route_to("fermexceptions#show", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/fermexceptions").to route_to("fermexceptions#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/fermexceptions/1").to route_to("fermexceptions#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/fermexceptions/1").to route_to("fermexceptions#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/fermexceptions/1").to route_to("fermexceptions#destroy", :id => "1")
    end
  end
end
