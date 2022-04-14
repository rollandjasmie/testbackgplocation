require "rails_helper"

RSpec.describe TarifDeBasesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/tarif_de_bases").to route_to("tarif_de_bases#index")
    end

    it "routes to #show" do
      expect(:get => "/tarif_de_bases/1").to route_to("tarif_de_bases#show", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/tarif_de_bases").to route_to("tarif_de_bases#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/tarif_de_bases/1").to route_to("tarif_de_bases#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/tarif_de_bases/1").to route_to("tarif_de_bases#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/tarif_de_bases/1").to route_to("tarif_de_bases#destroy", :id => "1")
    end
  end
end
