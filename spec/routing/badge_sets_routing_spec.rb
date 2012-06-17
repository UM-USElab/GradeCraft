require "spec_helper"

describe BadgeSetsController do
  describe "routing" do

    it "routes to #index" do
      get("/badge_sets").should route_to("badge_sets#index")
    end

    it "routes to #new" do
      get("/badge_sets/new").should route_to("badge_sets#new")
    end

    it "routes to #show" do
      get("/badge_sets/1").should route_to("badge_sets#show", :id => "1")
    end

    it "routes to #edit" do
      get("/badge_sets/1/edit").should route_to("badge_sets#edit", :id => "1")
    end

    it "routes to #create" do
      post("/badge_sets").should route_to("badge_sets#create")
    end

    it "routes to #update" do
      put("/badge_sets/1").should route_to("badge_sets#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/badge_sets/1").should route_to("badge_sets#destroy", :id => "1")
    end

  end
end
