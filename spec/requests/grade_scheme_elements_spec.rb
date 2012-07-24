require 'spec_helper'

describe "GradeSchemeElements" do
  describe "GET /grade_scheme_elements" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get grade_scheme_elements_path
      response.status.should be(200)
    end
  end
end
