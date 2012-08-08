require 'spec_helper'

describe "user_assignment_type_weights/edit" do
  before(:each) do
    @user_assignment_type_weight = assign(:user_assignment_type_weight, stub_model(UserAssignmentTypeWeight))
  end

  it "renders the edit user_assignment_type_weight form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => user_assignment_type_weights_path(@user_assignment_type_weight), :method => "post" do
    end
  end
end
