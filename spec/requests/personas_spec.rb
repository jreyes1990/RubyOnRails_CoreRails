require 'rails_helper'

RSpec.describe "Personas", type: :request do
  describe "GET /show" do
    it "returns http success" do
      get "/personas/show"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      get "/personas/edit"
      expect(response).to have_http_status(:success)
    end
  end

end
