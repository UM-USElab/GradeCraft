require 'spec_helper'

describe "badge_sets/index" do
  before(:each) do
    assign(:badge_sets, [
      stub_model(BadgeSet,
        :name => "Name",
        :notes => "Notes"
      ),
      stub_model(BadgeSet,
        :name => "Name",
        :notes => "Notes"
      )
    ])
  end

  it "renders a list of badge_sets" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Notes".to_s, :count => 2
  end
end
