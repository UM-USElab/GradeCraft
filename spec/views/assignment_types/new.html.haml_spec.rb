require 'spec_helper'

describe "assignment_types/new" do
  before(:each) do
    assign(:assignment_type, stub_model(AssignmentType,
      :name => "",
      :point_setting => "",
      :levels => "",
      :points_predictor_display => "",
      :due_date => "",
      :resubmission => "",
      :max_value => "",
      :percentage_course => "",
      :predictor_description => "MyString"
    ).as_new_record)
  end

  it "renders new assignment_type form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => assignment_types_path, :method => "post" do
      assert_select "input#assignment_type_name", :name => "assignment_type[name]"
      assert_select "input#assignment_type_point_setting", :name => "assignment_type[point_setting]"
      assert_select "input#assignment_type_levels", :name => "assignment_type[levels]"
      assert_select "input#assignment_type_points_predictor_display", :name => "assignment_type[points_predictor_display]"
      assert_select "input#assignment_type_due_date", :name => "assignment_type[due_date]"
      assert_select "input#assignment_type_resubmission", :name => "assignment_type[resubmission]"
      assert_select "input#assignment_type_max_value", :name => "assignment_type[max_value]"
      assert_select "input#assignment_type_percentage_course", :name => "assignment_type[percentage_course]"
      assert_select "input#assignment_type_predictor_description", :name => "assignment_type[predictor_description]"
    end
  end
end
