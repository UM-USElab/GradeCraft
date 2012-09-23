require 'spec_helper'

describe "rubrics/edit" do
  before(:each) do
    @rubric = assign(:rubric, stub_model(Rubric,
      :name => "MyString",
      :assignment_id => 1,
      :description => "MyText"
    ))
  end

  it "renders the edit rubric form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => rubrics_path(@rubric), :method => "post" do
      assert_select "input#rubric_name", :name => "rubric[name]"
      assert_select "input#rubric_assignment_id", :name => "rubric[assignment_id]"
      assert_select "textarea#rubric_description", :name => "rubric[description]"
    end
  end
end
