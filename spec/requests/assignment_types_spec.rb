require 'spec_helper'

describe "AssignmentTypes" do
  describe "GET /assignment_types" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get assignment_types_path
      response.status.should be(200)
    end
  end
end
