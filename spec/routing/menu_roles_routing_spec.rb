require "rails_helper"

RSpec.describe MenuRolesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/menu_roles").to route_to("menu_roles#index")
    end

    it "routes to #new" do
      expect(get: "/menu_roles/new").to route_to("menu_roles#new")
    end

    it "routes to #show" do
      expect(get: "/menu_roles/1").to route_to("menu_roles#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/menu_roles/1/edit").to route_to("menu_roles#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/menu_roles").to route_to("menu_roles#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/menu_roles/1").to route_to("menu_roles#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/menu_roles/1").to route_to("menu_roles#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/menu_roles/1").to route_to("menu_roles#destroy", id: "1")
    end
  end
end
