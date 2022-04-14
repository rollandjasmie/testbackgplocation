require 'rails_helper'

RSpec.describe "Fermexceptions", type: :request do
  describe "GET /fermexceptions" do
    it "works! (now write some real specs)" do
      get fermexceptions_path
      expect(response).to have_http_status(200)
    end
  end
end
