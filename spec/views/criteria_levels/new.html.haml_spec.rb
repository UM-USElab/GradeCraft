require 'spec_helper'

describe "criteria_levels/new" do
  before(:each) do
    assign(:criteria_level, stub_model(CriteriaLevel,
      :name => "MyString",
      :criteria_id => 1,
      :description => "MyText",
      :value => 1
    ).as_new_record)
  end

  it "renders new criteria_level form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => criteria_levels_path, :method => "post" do
      assert_select "input#criteria_level_name", :name => "criteria_level[name]"
      assert_select "input#criteria_level_criteria_id", :name => "criteria_level[criteria_id]"
      assert_select "textarea#criteria_level_description", :name => "criteria_level[description]"
      assert_select "input#criteria_level_value", :name => "criteria_level[value]"
    end
  end
end
