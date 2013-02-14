require 'spec_helper'

describe "faqs/show" do
  before(:each) do
    @faq = assign(:faq, stub_model(Faq,
      :question => "Question",
      :answer => "MyText",
      :order => 1,
      :category => "Category",
      :audience => "Audience"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Question/)
    rendered.should match(/MyText/)
    rendered.should match(/1/)
    rendered.should match(/Category/)
    rendered.should match(/Audience/)
  end
end
