require 'rails_helper'

RSpec.describe "HoraireJours", type: :request do
  describe "GET /horaire_jours" do
    it "works! (now write some real specs)" do
      get horaire_jours_path
      expect(response).to have_http_status(200)
    end
  end
end
