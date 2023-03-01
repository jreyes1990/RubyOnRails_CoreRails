require "rails_helper"

RSpec.describe AtributosController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/atributos").to route_to("atributos#index")
    end

    it "routes to #new" do
      expect(get: "/atributos/new").to route_to("atributos#new")
    end

    it "routes to #show" do
      expect(get: "/atributos/1").to route_to("atributos#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/atributos/1/edit").to route_to("atributos#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/atributos").to route_to("atributos#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/atributos/1").to route_to("atributos#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/atributos/1").to route_to("atributos#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/atributos/1").to route_to("atributos#destroy", id: "1")
    end
  end
end
