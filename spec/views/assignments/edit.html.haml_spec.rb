require 'spec_helper'

describe "assignments/edit.html.haml" do
  before(:each) do
    @assignment = assign(:assignment, stub_model(Assignment,
      :title => "MyString",
      :description => "MyString",
      :point_total => 1
    ))
  end

  it "renders the edit assignment form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => assignments_path(@assignment), :method => "post" do
      assert_select "input#assignment_title", :name => "assignment[title]"
      assert_select "input#assignment_description", :name => "assignment[description]"
      assert_select "input#assignment_point_total", :name => "assignment[point_total]"
    end
  end
end
