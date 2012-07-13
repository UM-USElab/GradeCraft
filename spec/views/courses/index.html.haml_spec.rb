require 'spec_helper'

describe "courses/index" do
  before(:each) do
    assign(:courses, [
      stub_model(Course,
        :name => "Name",
        :courseno => "Courseno",
        :semester => "Semester",
        :badgeset => 1,
        :theme => "Theme",
        :coursegradescheme => 2
      ),
      stub_model(Course,
        :name => "Name",
        :courseno => "Courseno",
        :semester => "Semester",
        :badgeset => 1,
        :theme => "Theme",
        :coursegradescheme => 2
      )
    ])
  end

  it "renders a list of courses" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Courseno".to_s, :count => 2
    assert_select "tr>td", :text => "Semester".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Theme".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
  end
end
