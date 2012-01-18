require 'spec_helper'

describe "grades/index.html.haml" do
  before(:each) do
    assign(:grades, [
      stub_model(Grade,
        :score => 1,
        :user => nil,
        :assignment => nil,
        :feedback => "Feedback",
        :badge => nil
      ),
      stub_model(Grade,
        :score => 1,
        :user => nil,
        :assignment => nil,
        :feedback => "Feedback",
        :badge => nil
      )
    ])
  end

  it "renders a list of grades" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => nil.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => nil.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Feedback".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
