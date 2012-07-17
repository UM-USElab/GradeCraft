require 'spec_helper'

describe "assignment_types/index" do
  before(:each) do
    assign(:assignment_types, [
      stub_model(AssignmentType,
        :name => "",
        :point_setting => "",
        :levels => "",
        :points_predictor_display => "",
        :due_date => "",
        :resubmission => "",
        :max_value => "",
        :percentage_course => "",
        :predictor_description => "Predictor Description"
      ),
      stub_model(AssignmentType,
        :name => "",
        :point_setting => "",
        :levels => "",
        :points_predictor_display => "",
        :due_date => "",
        :resubmission => "",
        :max_value => "",
        :percentage_course => "",
        :predictor_description => "Predictor Description"
      )
    ])
  end

  it "renders a list of assignment_types" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "Predictor Description".to_s, :count => 2
  end
end
