require "rails_helper"

RSpec.describe CodigoColoresController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/codigo_colores").to route_to("codigo_colores#index")
    end

    it "routes to #new" do
      expect(get: "/codigo_colores/new").to route_to("codigo_colores#new")
    end

    it "routes to #show" do
      expect(get: "/codigo_colores/1").to route_to("codigo_colores#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/codigo_colores/1/edit").to route_to("codigo_colores#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/codigo_colores").to route_to("codigo_colores#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/codigo_colores/1").to route_to("codigo_colores#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/codigo_colores/1").to route_to("codigo_colores#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/codigo_colores/1").to route_to("codigo_colores#destroy", id: "1")
    end
  end
end
