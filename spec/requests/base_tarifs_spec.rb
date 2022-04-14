require 'rails_helper'

RSpec.describe "BaseTarifs", type: :request do
  describe "GET /base_tarifs" do
    it "works! (now write some real specs)" do
      get base_tarifs_path
      expect(response).to have_http_status(200)
    end
  end
end
