require "rails_helper"

RSpec.describe PersonaEmpresaFormulariosController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/persona_empresa_formularios").to route_to("persona_empresa_formularios#index")
    end

    it "routes to #new" do
      expect(get: "/persona_empresa_formularios/new").to route_to("persona_empresa_formularios#new")
    end

    it "routes to #show" do
      expect(get: "/persona_empresa_formularios/1").to route_to("persona_empresa_formularios#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/persona_empresa_formularios/1/edit").to route_to("persona_empresa_formularios#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/persona_empresa_formularios").to route_to("persona_empresa_formularios#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/persona_empresa_formularios/1").to route_to("persona_empresa_formularios#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/persona_empresa_formularios/1").to route_to("persona_empresa_formularios#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/persona_empresa_formularios/1").to route_to("persona_empresa_formularios#destroy", id: "1")
    end
  end
end
