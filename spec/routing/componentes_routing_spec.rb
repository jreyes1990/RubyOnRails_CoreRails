require "rails_helper"

RSpec.describe ComponentesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/componentes").to route_to("componentes#index")
    end

    it "routes to #new" do
      expect(get: "/componentes/new").to route_to("componentes#new")
    end

    it "routes to #show" do
      expect(get: "/componentes/1").to route_to("componentes#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/componentes/1/edit").to route_to("componentes#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/componentes").to route_to("componentes#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/componentes/1").to route_to("componentes#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/componentes/1").to route_to("componentes#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/componentes/1").to route_to("componentes#destroy", id: "1")
    end
  end
end
