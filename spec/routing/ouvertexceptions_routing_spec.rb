require "rails_helper"

RSpec.describe OuvertexceptionsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/ouvertexceptions").to route_to("ouvertexceptions#index")
    end

    it "routes to #show" do
      expect(:get => "/ouvertexceptions/1").to route_to("ouvertexceptions#show", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/ouvertexceptions").to route_to("ouvertexceptions#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/ouvertexceptions/1").to route_to("ouvertexceptions#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/ouvertexceptions/1").to route_to("ouvertexceptions#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/ouvertexceptions/1").to route_to("ouvertexceptions#destroy", :id => "1")
    end
  end
end
