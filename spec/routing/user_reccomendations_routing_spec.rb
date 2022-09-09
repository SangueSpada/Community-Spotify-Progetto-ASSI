require "rails_helper"

RSpec.describe UserReccomendationsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/user_reccomendations").to route_to("user_reccomendations#index")
    end

    it "routes to #new" do
      expect(get: "/user_reccomendations/new").to route_to("user_reccomendations#new")
    end

    it "routes to #show" do
      expect(get: "/user_reccomendations/1").to route_to("user_reccomendations#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/user_reccomendations/1/edit").to route_to("user_reccomendations#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/user_reccomendations").to route_to("user_reccomendations#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/user_reccomendations/1").to route_to("user_reccomendations#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/user_reccomendations/1").to route_to("user_reccomendations#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/user_reccomendations/1").to route_to("user_reccomendations#destroy", id: "1")
    end
  end
end
