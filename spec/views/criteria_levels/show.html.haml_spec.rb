require 'spec_helper'

describe "criteria_levels/show" do
  before(:each) do
    @criteria_level = assign(:criteria_level, stub_model(CriteriaLevel,
      :name => "Name",
      :criteria_id => 1,
      :description => "MyText",
      :value => 2
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/1/)
    rendered.should match(/MyText/)
    rendered.should match(/2/)
  end
end
