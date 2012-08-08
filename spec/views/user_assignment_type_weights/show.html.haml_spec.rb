require 'spec_helper'

describe "user_assignment_type_weights/show" do
  before(:each) do
    @user_assignment_type_weight = assign(:user_assignment_type_weight, stub_model(UserAssignmentTypeWeight))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
