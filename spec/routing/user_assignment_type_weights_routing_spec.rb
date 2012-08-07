require "spec_helper"

describe UserAssignmentTypeWeightsController do
  describe "routing" do

    it "routes to #index" do
      get("/user_assignment_type_weights").should route_to("user_assignment_type_weights#index")
    end

    it "routes to #new" do
      get("/user_assignment_type_weights/new").should route_to("user_assignment_type_weights#new")
    end

    it "routes to #show" do
      get("/user_assignment_type_weights/1").should route_to("user_assignment_type_weights#show", :id => "1")
    end

    it "routes to #edit" do
      get("/user_assignment_type_weights/1/edit").should route_to("user_assignment_type_weights#edit", :id => "1")
    end

    it "routes to #create" do
      post("/user_assignment_type_weights").should route_to("user_assignment_type_weights#create")
    end

    it "routes to #update" do
      put("/user_assignment_type_weights/1").should route_to("user_assignment_type_weights#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/user_assignment_type_weights/1").should route_to("user_assignment_type_weights#destroy", :id => "1")
    end

  end
end
