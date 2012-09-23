require 'spec_helper'

describe "criteria/index" do
  before(:each) do
    assign(:criteria, [
      stub_model(Criterium,
        :name => "Name",
        :ruberic_id => 1,
        :description => "MyText"
      ),
      stub_model(Criterium,
        :name => "Name",
        :ruberic_id => 1,
        :description => "MyText"
      )
    ])
  end

  it "renders a list of criteria" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
