require 'spec_helper'

describe "assignment_types/show" do
  before(:each) do
    @assignment_type = assign(:assignment_type, stub_model(AssignmentType,
      :name => "",
      :point_setting => "",
      :levels => "",
      :points_predictor_display => "",
      :due_date => "",
      :resubmission => "",
      :max_value => "",
      :percentage_course => "",
      :predictor_description => "Predictor Description"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
    rendered.should match(//)
    rendered.should match(//)
    rendered.should match(//)
    rendered.should match(//)
    rendered.should match(//)
    rendered.should match(//)
    rendered.should match(//)
    rendered.should match(/Predictor Description/)
  end
end
