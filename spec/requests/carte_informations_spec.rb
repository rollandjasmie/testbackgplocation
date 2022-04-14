require 'rails_helper'

RSpec.describe "CarteInformations", type: :request do
  describe "GET /carte_informations" do
    it "works! (now write some real specs)" do
      get carte_informations_path
      expect(response).to have_http_status(200)
    end
  end
end
