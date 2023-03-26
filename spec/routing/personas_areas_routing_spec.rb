require "rails_helper"

RSpec.describe PersonasAreasController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/personas_areas").to route_to("personas_areas#index")
    end

    it "routes to #new" do
      expect(get: "/personas_areas/new").to route_to("personas_areas#new")
    end

    it "routes to #show" do
      expect(get: "/personas_areas/1").to route_to("personas_areas#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/personas_areas/1/edit").to route_to("personas_areas#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/personas_areas").to route_to("personas_areas#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/personas_areas/1").to route_to("personas_areas#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/personas_areas/1").to route_to("personas_areas#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/personas_areas/1").to route_to("personas_areas#destroy", id: "1")
    end
  end
end
