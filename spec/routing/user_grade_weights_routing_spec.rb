require "spec_helper"

describe UserGradeWeightsController do
  describe "routing" do

    it "routes to #index" do
      get("/user_grade_weights").should route_to("user_grade_weights#index")
    end

    it "routes to #new" do
      get("/user_grade_weights/new").should route_to("user_grade_weights#new")
    end

    it "routes to #show" do
      get("/user_grade_weights/1").should route_to("user_grade_weights#show", :id => "1")
    end

    it "routes to #edit" do
      get("/user_grade_weights/1/edit").should route_to("user_grade_weights#edit", :id => "1")
    end

    it "routes to #create" do
      post("/user_grade_weights").should route_to("user_grade_weights#create")
    end

    it "routes to #update" do
      put("/user_grade_weights/1").should route_to("user_grade_weights#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/user_grade_weights/1").should route_to("user_grade_weights#destroy", :id => "1")
    end

  end
end
