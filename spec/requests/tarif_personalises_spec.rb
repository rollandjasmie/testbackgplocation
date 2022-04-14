require 'rails_helper'

RSpec.describe "TarifPersonalises", type: :request do
  describe "GET /tarif_personalises" do
    it "works! (now write some real specs)" do
      get tarif_personalises_path
      expect(response).to have_http_status(200)
    end
  end
end
