require "spec_helper"

describe AssignmentSubmissionsController do
  describe "routing" do

    it "routes to #index" do
      get("/assignment_submissions").should route_to("assignment_submissions#index")
    end

    it "routes to #new" do
      get("/assignment_submissions/new").should route_to("assignment_submissions#new")
    end

    it "routes to #show" do
      get("/assignment_submissions/1").should route_to("assignment_submissions#show", :id => "1")
    end

    it "routes to #edit" do
      get("/assignment_submissions/1/edit").should route_to("assignment_submissions#edit", :id => "1")
    end

    it "routes to #create" do
      post("/assignment_submissions").should route_to("assignment_submissions#create")
    end

    it "routes to #update" do
      put("/assignment_submissions/1").should route_to("assignment_submissions#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/assignment_submissions/1").should route_to("assignment_submissions#destroy", :id => "1")
    end

  end
end
