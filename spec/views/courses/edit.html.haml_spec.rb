require 'spec_helper'

describe "courses/edit" do
  before(:each) do
    @course = assign(:course, stub_model(Course,
      :name => "MyString",
      :courseno => "MyString",
      :semester => "MyString",
      :badgeset => 1,
      :theme => "MyString",
      :coursegradescheme => 1
    ))
  end

  it "renders the edit course form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => courses_path(@course), :method => "post" do
      assert_select "input#course_name", :name => "course[name]"
      assert_select "input#course_courseno", :name => "course[courseno]"
      assert_select "input#course_semester", :name => "course[semester]"
      assert_select "input#course_badgeset", :name => "course[badgeset]"
      assert_select "input#course_theme", :name => "course[theme]"
      assert_select "input#course_coursegradescheme", :name => "course[coursegradescheme]"
    end
  end
end
