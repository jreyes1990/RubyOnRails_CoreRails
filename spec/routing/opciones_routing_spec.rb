require "rails_helper"

RSpec.describe OpcionesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/opciones").to route_to("opciones#index")
    end

    it "routes to #new" do
      expect(get: "/opciones/new").to route_to("opciones#new")
    end

    it "routes to #show" do
      expect(get: "/opciones/1").to route_to("opciones#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/opciones/1/edit").to route_to("opciones#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/opciones").to route_to("opciones#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/opciones/1").to route_to("opciones#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/opciones/1").to route_to("opciones#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/opciones/1").to route_to("opciones#destroy", id: "1")
    end
  end
end
