require "spec_helper"

describe CriteriaLevelsController do
  describe "routing" do

    it "routes to #index" do
      get("/criteria_levels").should route_to("criteria_levels#index")
    end

    it "routes to #new" do
      get("/criteria_levels/new").should route_to("criteria_levels#new")
    end

    it "routes to #show" do
      get("/criteria_levels/1").should route_to("criteria_levels#show", :id => "1")
    end

    it "routes to #edit" do
      get("/criteria_levels/1/edit").should route_to("criteria_levels#edit", :id => "1")
    end

    it "routes to #create" do
      post("/criteria_levels").should route_to("criteria_levels#create")
    end

    it "routes to #update" do
      put("/criteria_levels/1").should route_to("criteria_levels#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/criteria_levels/1").should route_to("criteria_levels#destroy", :id => "1")
    end

  end
end
