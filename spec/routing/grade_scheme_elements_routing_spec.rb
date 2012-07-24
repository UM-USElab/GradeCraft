require "spec_helper"

describe GradeSchemeElementsController do
  describe "routing" do

    it "routes to #index" do
      get("/grade_scheme_elements").should route_to("grade_scheme_elements#index")
    end

    it "routes to #new" do
      get("/grade_scheme_elements/new").should route_to("grade_scheme_elements#new")
    end

    it "routes to #show" do
      get("/grade_scheme_elements/1").should route_to("grade_scheme_elements#show", :id => "1")
    end

    it "routes to #edit" do
      get("/grade_scheme_elements/1/edit").should route_to("grade_scheme_elements#edit", :id => "1")
    end

    it "routes to #create" do
      post("/grade_scheme_elements").should route_to("grade_scheme_elements#create")
    end

    it "routes to #update" do
      put("/grade_scheme_elements/1").should route_to("grade_scheme_elements#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/grade_scheme_elements/1").should route_to("grade_scheme_elements#destroy", :id => "1")
    end

  end
end
