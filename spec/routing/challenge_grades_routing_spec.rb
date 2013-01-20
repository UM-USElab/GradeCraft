require "spec_helper"

describe ChallengeGradesController do
  describe "routing" do

    it "routes to #index" do
      get("/challenge_grades").should route_to("challenge_grades#index")
    end

    it "routes to #new" do
      get("/challenge_grades/new").should route_to("challenge_grades#new")
    end

    it "routes to #show" do
      get("/challenge_grades/1").should route_to("challenge_grades#show", :id => "1")
    end

    it "routes to #edit" do
      get("/challenge_grades/1/edit").should route_to("challenge_grades#edit", :id => "1")
    end

    it "routes to #create" do
      post("/challenge_grades").should route_to("challenge_grades#create")
    end

    it "routes to #update" do
      put("/challenge_grades/1").should route_to("challenge_grades#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/challenge_grades/1").should route_to("challenge_grades#destroy", :id => "1")
    end

  end
end
