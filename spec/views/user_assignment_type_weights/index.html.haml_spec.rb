require 'spec_helper'

describe "user_assignment_type_weights/index" do
  before(:each) do
    assign(:user_assignment_type_weights, [
      stub_model(UserAssignmentTypeWeight),
      stub_model(UserAssignmentTypeWeight)
    ])
  end

  it "renders a list of user_assignment_type_weights" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
