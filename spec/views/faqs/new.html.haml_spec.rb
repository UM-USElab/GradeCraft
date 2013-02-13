require 'spec_helper'

describe "faqs/new" do
  before(:each) do
    assign(:faq, stub_model(Faq,
      :question => "MyString",
      :answer => "MyText",
      :order => 1,
      :category => "MyString",
      :audience => "MyString"
    ).as_new_record)
  end

  it "renders new faq form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => faqs_path, :method => "post" do
      assert_select "input#faq_question", :name => "faq[question]"
      assert_select "textarea#faq_answer", :name => "faq[answer]"
      assert_select "input#faq_order", :name => "faq[order]"
      assert_select "input#faq_category", :name => "faq[category]"
      assert_select "input#faq_audience", :name => "faq[audience]"
    end
  end
end
