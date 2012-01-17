require 'spec_helper'

describe "badges/index.html.haml" do
  before(:each) do
    assign(:badges, [
      stub_model(Badge,
        :title => "Title",
        :description => "Description",
        :icon => "Icon",
        :visible => ""
      ),
      stub_model(Badge,
        :title => "Title",
        :description => "Description",
        :icon => "Icon",
        :visible => ""
      )
    ])
  end

  it "renders a list of badges" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Description".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Icon".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "".to_s, :count => 2
  end
end
