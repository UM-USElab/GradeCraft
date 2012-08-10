require 'spec_helper'

describe "AssignmentSubmissions" do
  describe "GET /assignment_submissions" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get assignment_submissions_path
      response.status.should be(200)
    end
  end
end
