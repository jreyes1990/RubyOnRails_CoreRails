require "rails_helper"

RSpec.describe OpcionCasController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/opcion_cas").to route_to("opcion_cas#index")
    end

    it "routes to #new" do
      expect(get: "/opcion_cas/new").to route_to("opcion_cas#new")
    end

    it "routes to #show" do
      expect(get: "/opcion_cas/1").to route_to("opcion_cas#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/opcion_cas/1/edit").to route_to("opcion_cas#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/opcion_cas").to route_to("opcion_cas#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/opcion_cas/1").to route_to("opcion_cas#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/opcion_cas/1").to route_to("opcion_cas#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/opcion_cas/1").to route_to("opcion_cas#destroy", id: "1")
    end
  end
end
