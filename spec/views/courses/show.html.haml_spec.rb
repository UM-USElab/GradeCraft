require 'spec_helper'

describe "courses/show" do
  before(:each) do
    @course = assign(:course, stub_model(Course,
      :name => "Name",
      :courseno => "Courseno",
      :semester => "Semester",
      :badgeset => 1,
      :theme => "Theme",
      :coursegradescheme => 2
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/Courseno/)
    rendered.should match(/Semester/)
    rendered.should match(/1/)
    rendered.should match(/Theme/)
    rendered.should match(/2/)
  end
end
