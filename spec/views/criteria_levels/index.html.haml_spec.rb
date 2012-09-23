require 'spec_helper'

describe "criteria_levels/index" do
  before(:each) do
    assign(:criteria_levels, [
      stub_model(CriteriaLevel,
        :name => "Name",
        :criteria_id => 1,
        :description => "MyText",
        :value => 2
      ),
      stub_model(CriteriaLevel,
        :name => "Name",
        :criteria_id => 1,
        :description => "MyText",
        :value => 2
      )
    ])
  end

  it "renders a list of criteria_levels" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
  end
end
