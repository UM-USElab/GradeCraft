require "spec_helper"

describe CriteriaController do
  describe "routing" do

    it "routes to #index" do
      get("/criteria").should route_to("criteria#index")
    end

    it "routes to #new" do
      get("/criteria/new").should route_to("criteria#new")
    end

    it "routes to #show" do
      get("/criteria/1").should route_to("criteria#show", :id => "1")
    end

    it "routes to #edit" do
      get("/criteria/1/edit").should route_to("criteria#edit", :id => "1")
    end

    it "routes to #create" do
      post("/criteria").should route_to("criteria#create")
    end

    it "routes to #update" do
      put("/criteria/1").should route_to("criteria#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/criteria/1").should route_to("criteria#destroy", :id => "1")
    end

  end
end
