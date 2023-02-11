require "rails_helper"

RSpec.describe FontAwesomesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/font_awesomes").to route_to("font_awesomes#index")
    end

    it "routes to #new" do
      expect(get: "/font_awesomes/new").to route_to("font_awesomes#new")
    end

    it "routes to #show" do
      expect(get: "/font_awesomes/1").to route_to("font_awesomes#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/font_awesomes/1/edit").to route_to("font_awesomes#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/font_awesomes").to route_to("font_awesomes#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/font_awesomes/1").to route_to("font_awesomes#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/font_awesomes/1").to route_to("font_awesomes#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/font_awesomes/1").to route_to("font_awesomes#destroy", id: "1")
    end
  end
end
