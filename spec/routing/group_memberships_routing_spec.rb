require "spec_helper"

describe GroupMembershipsController do
  describe "routing" do

    it "routes to #index" do
      get("/group_memberships").should route_to("group_memberships#index")
    end

    it "routes to #new" do
      get("/group_memberships/new").should route_to("group_memberships#new")
    end

    it "routes to #show" do
      get("/group_memberships/1").should route_to("group_memberships#show", :id => "1")
    end

    it "routes to #edit" do
      get("/group_memberships/1/edit").should route_to("group_memberships#edit", :id => "1")
    end

    it "routes to #create" do
      post("/group_memberships").should route_to("group_memberships#create")
    end

    it "routes to #update" do
      put("/group_memberships/1").should route_to("group_memberships#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/group_memberships/1").should route_to("group_memberships#destroy", :id => "1")
    end

  end
end
