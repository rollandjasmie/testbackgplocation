require "rails_helper"

RSpec.describe HoraireJoursController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/horaire_jours").to route_to("horaire_jours#index")
    end

    it "routes to #show" do
      expect(:get => "/horaire_jours/1").to route_to("horaire_jours#show", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/horaire_jours").to route_to("horaire_jours#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/horaire_jours/1").to route_to("horaire_jours#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/horaire_jours/1").to route_to("horaire_jours#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/horaire_jours/1").to route_to("horaire_jours#destroy", :id => "1")
    end
  end
end
