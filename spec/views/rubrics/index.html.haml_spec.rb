require 'spec_helper'

describe "rubrics/index" do
  before(:each) do
    assign(:rubrics, [
      stub_model(Rubric,
        :name => "Name",
        :assignment_id => 1,
        :description => "MyText"
      ),
      stub_model(Rubric,
        :name => "Name",
        :assignment_id => 1,
        :description => "MyText"
      )
    ])
  end

  it "renders a list of rubrics" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
