require 'spec_helper'

describe "course_grade_schemes/edit" do
  before(:each) do
    @course_grade_scheme = assign(:course_grade_scheme, stub_model(CourseGradeScheme,
      :name => "MyString"
    ))
  end

  it "renders the edit course_grade_scheme form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => course_grade_schemes_path(@course_grade_scheme), :method => "post" do
      assert_select "input#course_grade_scheme_name", :name => "course_grade_scheme[name]"
    end
  end
end
