require "rails_helper"

RSpec.describe EmpresasController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/empresas").to route_to("empresas#index")
    end

    it "routes to #new" do
      expect(get: "/empresas/new").to route_to("empresas#new")
    end

    it "routes to #show" do
      expect(get: "/empresas/1").to route_to("empresas#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/empresas/1/edit").to route_to("empresas#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/empresas").to route_to("empresas#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/empresas/1").to route_to("empresas#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/empresas/1").to route_to("empresas#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/empresas/1").to route_to("empresas#destroy", id: "1")
    end
  end
end
