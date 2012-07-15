require "spec_helper"

describe NewsController do
  describe "routing" do

    it "routes to #index" do
      get("/news").should route_to("news#index")
    end

    it "routes to #new" do
      get("/news/new").should route_to("news#new")
    end

    it "routes to #show" do
      get("/news/1").should route_to("news#show", :id => "1")
    end

    it "routes to #edit" do
      get("/news/1/edit").should route_to("news#edit", :id => "1")
    end

    it "routes to #create" do
      post("/news").should route_to("news#create")
    end

    it "routes to #update" do
      put("/news/1").should route_to("news#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/news/1").should route_to("news#destroy", :id => "1")
    end

  end
end
