require "rails_helper"

RSpec.describe AdminReservationsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/admin_reservations").to route_to("admin_reservations#index")
    end

    it "routes to #show" do
      expect(:get => "/admin_reservations/1").to route_to("admin_reservations#show", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/admin_reservations").to route_to("admin_reservations#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/admin_reservations/1").to route_to("admin_reservations#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/admin_reservations/1").to route_to("admin_reservations#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/admin_reservations/1").to route_to("admin_reservations#destroy", :id => "1")
    end
  end
end
