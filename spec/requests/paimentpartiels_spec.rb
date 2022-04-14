require 'rails_helper'

RSpec.describe "Paimentpartiels", type: :request do
  describe "GET /paimentpartiels" do
    it "works! (now write some real specs)" do
      get paimentpartiels_path
      expect(response).to have_http_status(200)
    end
  end
end
