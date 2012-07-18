require "spec_helper"

describe AssignmentTypesController do
  describe "routing" do

    it "routes to #index" do
      get("/assignment_types").should route_to("assignment_types#index")
    end

    it "routes to #new" do
      get("/assignment_types/new").should route_to("assignment_types#new")
    end

    it "routes to #show" do
      get("/assignment_types/1").should route_to("assignment_types#show", :id => "1")
    end

    it "routes to #edit" do
      get("/assignment_types/1/edit").should route_to("assignment_types#edit", :id => "1")
    end

    it "routes to #create" do
      post("/assignment_types").should route_to("assignment_types#create")
    end

    it "routes to #update" do
      put("/assignment_types/1").should route_to("assignment_types#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/assignment_types/1").should route_to("assignment_types#destroy", :id => "1")
    end

  end
end
