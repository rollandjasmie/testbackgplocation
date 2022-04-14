require 'rails_helper'

RSpec.describe "TarifDeBases", type: :request do
  describe "GET /tarif_de_bases" do
    it "works! (now write some real specs)" do
      get tarif_de_bases_path
      expect(response).to have_http_status(200)
    end
  end
end
