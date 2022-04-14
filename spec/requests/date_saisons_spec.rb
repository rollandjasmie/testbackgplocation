require 'rails_helper'

RSpec.describe "DateSaisons", type: :request do
  describe "GET /date_saisons" do
    it "works! (now write some real specs)" do
      get date_saisons_path
      expect(response).to have_http_status(200)
    end
  end
end
