require 'spec_helper'

describe "user_assignment_type_weights/new" do
  before(:each) do
    assign(:user_assignment_type_weight, stub_model(UserAssignmentTypeWeight).as_new_record)
  end

  it "renders new user_assignment_type_weight form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => user_assignment_type_weights_path, :method => "post" do
    end
  end
end
