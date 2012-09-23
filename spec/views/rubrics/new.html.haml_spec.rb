require 'spec_helper'

describe "rubrics/new" do
  before(:each) do
    assign(:rubric, stub_model(Rubric,
      :name => "MyString",
      :assignment_id => 1,
      :description => "MyText"
    ).as_new_record)
  end

  it "renders new rubric form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => rubrics_path, :method => "post" do
      assert_select "input#rubric_name", :name => "rubric[name]"
      assert_select "input#rubric_assignment_id", :name => "rubric[assignment_id]"
      assert_select "textarea#rubric_description", :name => "rubric[description]"
    end
  end
end
