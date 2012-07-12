require "spec_helper"

describe CourseGradeSchemesController do
  describe "routing" do

    it "routes to #index" do
      get("/course_grade_schemes").should route_to("course_grade_schemes#index")
    end

    it "routes to #new" do
      get("/course_grade_schemes/new").should route_to("course_grade_schemes#new")
    end

    it "routes to #show" do
      get("/course_grade_schemes/1").should route_to("course_grade_schemes#show", :id => "1")
    end

    it "routes to #edit" do
      get("/course_grade_schemes/1/edit").should route_to("course_grade_schemes#edit", :id => "1")
    end

    it "routes to #create" do
      post("/course_grade_schemes").should route_to("course_grade_schemes#create")
    end

    it "routes to #update" do
      put("/course_grade_schemes/1").should route_to("course_grade_schemes#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/course_grade_schemes/1").should route_to("course_grade_schemes#destroy", :id => "1")
    end

  end
end
