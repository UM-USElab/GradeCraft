require 'spec_helper'

describe "course_grade_schemes/show" do
  before(:each) do
    @course_grade_scheme = assign(:course_grade_scheme, stub_model(CourseGradeScheme,
      :name => "Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
  end
end
