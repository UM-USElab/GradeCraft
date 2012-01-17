require 'spec_helper'

describe "badges/new.html.haml" do
  before(:each) do
    assign(:badge, stub_model(Badge,
      :title => "MyString",
      :description => "MyString",
      :icon => "MyString",
      :visible => ""
    ).as_new_record)
  end

  it "renders new badge form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => badges_path, :method => "post" do
      assert_select "input#badge_title", :name => "badge[title]"
      assert_select "input#badge_description", :name => "badge[description]"
      assert_select "input#badge_icon", :name => "badge[icon]"
      assert_select "input#badge_visible", :name => "badge[visible]"
    end
  end
end
