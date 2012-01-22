require "spec_helper"

describe ChallengesController do
  describe "routing" do

    it "routes to #index" do
      get("/challenges").should route_to("challenges#index")
    end

    it "routes to #new" do
      get("/challenges/new").should route_to("challenges#new")
    end

    it "routes to #show" do
      get("/challenges/1").should route_to("challenges#show", :id => "1")
    end

    it "routes to #edit" do
      get("/challenges/1/edit").should route_to("challenges#edit", :id => "1")
    end

    it "routes to #create" do
      post("/challenges").should route_to("challenges#create")
    end

    it "routes to #update" do
      put("/challenges/1").should route_to("challenges#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/challenges/1").should route_to("challenges#destroy", :id => "1")
    end

  end
end
