require 'spec_helper'

describe "faqs/index" do
  before(:each) do
    assign(:faqs, [
      stub_model(Faq,
        :question => "Question",
        :answer => "MyText",
        :order => 1,
        :category => "Category",
        :audience => "Audience"
      ),
      stub_model(Faq,
        :question => "Question",
        :answer => "MyText",
        :order => 1,
        :category => "Category",
        :audience => "Audience"
      )
    ])
  end

  it "renders a list of faqs" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Question".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Category".to_s, :count => 2
    assert_select "tr>td", :text => "Audience".to_s, :count => 2
  end
end
