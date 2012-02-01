require "spec_helper"

describe GradeSchemesController do
  describe "routing" do

    it "routes to #index" do
      get("/grade_schemes").should route_to("grade_schemes#index")
    end

    it "routes to #new" do
      get("/grade_schemes/new").should route_to("grade_schemes#new")
    end

    it "routes to #show" do
      get("/grade_schemes/1").should route_to("grade_schemes#show", :id => "1")
    end

    it "routes to #edit" do
      get("/grade_schemes/1/edit").should route_to("grade_schemes#edit", :id => "1")
    end

    it "routes to #create" do
      post("/grade_schemes").should route_to("grade_schemes#create")
    end

    it "routes to #update" do
      put("/grade_schemes/1").should route_to("grade_schemes#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/grade_schemes/1").should route_to("grade_schemes#destroy", :id => "1")
    end

  end
end
