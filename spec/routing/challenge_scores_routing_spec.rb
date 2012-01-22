require "spec_helper"

describe ChallengeScoresController do
  describe "routing" do

    it "routes to #index" do
      get("/challenge_scores").should route_to("challenge_scores#index")
    end

    it "routes to #new" do
      get("/challenge_scores/new").should route_to("challenge_scores#new")
    end

    it "routes to #show" do
      get("/challenge_scores/1").should route_to("challenge_scores#show", :id => "1")
    end

    it "routes to #edit" do
      get("/challenge_scores/1/edit").should route_to("challenge_scores#edit", :id => "1")
    end

    it "routes to #create" do
      post("/challenge_scores").should route_to("challenge_scores#create")
    end

    it "routes to #update" do
      put("/challenge_scores/1").should route_to("challenge_scores#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/challenge_scores/1").should route_to("challenge_scores#destroy", :id => "1")
    end

  end
end
