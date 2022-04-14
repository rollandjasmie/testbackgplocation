require "rails_helper"

RSpec.describe CarteInformationsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/carte_informations").to route_to("carte_informations#index")
    end

    it "routes to #show" do
      expect(:get => "/carte_informations/1").to route_to("carte_informations#show", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/carte_informations").to route_to("carte_informations#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/carte_informations/1").to route_to("carte_informations#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/carte_informations/1").to route_to("carte_informations#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/carte_informations/1").to route_to("carte_informations#destroy", :id => "1")
    end
  end
end
