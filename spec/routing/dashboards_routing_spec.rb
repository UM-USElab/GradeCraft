require "spec_helper"

describe DashboardsController do
  describe "routing" do

    it "routes to #index" do
      get("/dashboards").should route_to("dashboards#index")
    end

    it "routes to #new" do
      get("/dashboards/new").should route_to("dashboards#new")
    end

    it "routes to #show" do
      get("/dashboards/1").should route_to("dashboards#show", :id => "1")
    end

    it "routes to #edit" do
      get("/dashboards/1/edit").should route_to("dashboards#edit", :id => "1")
    end

    it "routes to #create" do
      post("/dashboards").should route_to("dashboards#create")
    end

    it "routes to #update" do
      put("/dashboards/1").should route_to("dashboards#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/dashboards/1").should route_to("dashboards#destroy", :id => "1")
    end

  end
end
