require "rails_helper"

RSpec.describe TarifPersonalisesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/tarif_personalises").to route_to("tarif_personalises#index")
    end

    it "routes to #show" do
      expect(:get => "/tarif_personalises/1").to route_to("tarif_personalises#show", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/tarif_personalises").to route_to("tarif_personalises#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/tarif_personalises/1").to route_to("tarif_personalises#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/tarif_personalises/1").to route_to("tarif_personalises#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/tarif_personalises/1").to route_to("tarif_personalises#destroy", :id => "1")
    end
  end
end
