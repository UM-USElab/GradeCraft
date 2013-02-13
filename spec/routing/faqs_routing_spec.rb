require "spec_helper"

describe FaqsController do
  describe "routing" do

    it "routes to #index" do
      get("/faqs").should route_to("faqs#index")
    end

    it "routes to #new" do
      get("/faqs/new").should route_to("faqs#new")
    end

    it "routes to #show" do
      get("/faqs/1").should route_to("faqs#show", :id => "1")
    end

    it "routes to #edit" do
      get("/faqs/1/edit").should route_to("faqs#edit", :id => "1")
    end

    it "routes to #create" do
      post("/faqs").should route_to("faqs#create")
    end

    it "routes to #update" do
      put("/faqs/1").should route_to("faqs#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/faqs/1").should route_to("faqs#destroy", :id => "1")
    end

  end
end
