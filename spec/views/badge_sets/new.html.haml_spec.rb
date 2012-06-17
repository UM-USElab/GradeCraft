require 'spec_helper'

describe "badge_sets/new" do
  before(:each) do
    assign(:badge_set, stub_model(BadgeSet,
      :name => "MyString",
      :notes => "MyString"
    ).as_new_record)
  end

  it "renders new badge_set form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => badge_sets_path, :method => "post" do
      assert_select "input#badge_set_name", :name => "badge_set[name]"
      assert_select "input#badge_set_notes", :name => "badge_set[notes]"
    end
  end
end
