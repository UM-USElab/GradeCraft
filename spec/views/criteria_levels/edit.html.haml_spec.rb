require 'spec_helper'

describe "criteria_levels/edit" do
  before(:each) do
    @criteria_level = assign(:criteria_level, stub_model(CriteriaLevel,
      :name => "MyString",
      :criteria_id => 1,
      :description => "MyText",
      :value => 1
    ))
  end

  it "renders the edit criteria_level form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => criteria_levels_path(@criteria_level), :method => "post" do
      assert_select "input#criteria_level_name", :name => "criteria_level[name]"
      assert_select "input#criteria_level_criteria_id", :name => "criteria_level[criteria_id]"
      assert_select "textarea#criteria_level_description", :name => "criteria_level[description]"
      assert_select "input#criteria_level_value", :name => "criteria_level[value]"
    end
  end
end
