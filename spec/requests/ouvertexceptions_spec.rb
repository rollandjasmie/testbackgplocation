require 'rails_helper'

RSpec.describe "Ouvertexceptions", type: :request do
  describe "GET /ouvertexceptions" do
    it "works! (now write some real specs)" do
      get ouvertexceptions_path
      expect(response).to have_http_status(200)
    end
  end
end
