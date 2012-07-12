require 'spec_helper'

describe "course_grade_schemes/index" do
  before(:each) do
    assign(:course_grade_schemes, [
      stub_model(CourseGradeScheme,
        :name => "Name"
      ),
      stub_model(CourseGradeScheme,
        :name => "Name"
      )
    ])
  end

  it "renders a list of course_grade_schemes" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
  end
end
