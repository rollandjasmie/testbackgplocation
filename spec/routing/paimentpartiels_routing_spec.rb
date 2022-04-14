require "rails_helper"

RSpec.describe PaimentpartielsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/paimentpartiels").to route_to("paimentpartiels#index")
    end

    it "routes to #show" do
      expect(:get => "/paimentpartiels/1").to route_to("paimentpartiels#show", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/paimentpartiels").to route_to("paimentpartiels#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/paimentpartiels/1").to route_to("paimentpartiels#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/paimentpartiels/1").to route_to("paimentpartiels#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/paimentpartiels/1").to route_to("paimentpartiels#destroy", :id => "1")
    end
  end
end
