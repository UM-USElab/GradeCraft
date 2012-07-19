require 'spec_helper'

describe "news/index" do
  before(:each) do
    assign(:news, [
      stub_model(News,
        :title => "Title",
        :content => "Content"
      ),
      stub_model(News,
        :title => "Title",
        :content => "Content"
      )
    ])
  end

  it "renders a list of news" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "Content".to_s, :count => 2
  end
end
