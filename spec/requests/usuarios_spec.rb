require 'rails_helper'

RSpec.describe "Usuarios", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/usuarios/index"
      expect(response).to have_http_status(:success)
    end
  end

end
