require 'spec_helper'

describe "BadgeSets" do
  describe "GET /badge_sets" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get badge_sets_path
      response.status.should be(200)
    end
  end
end
