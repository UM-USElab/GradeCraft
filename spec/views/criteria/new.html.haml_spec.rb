require 'spec_helper'

describe "criteria/new" do
  before(:each) do
    assign(:criterium, stub_model(Criterium,
      :name => "MyString",
      :ruberic_id => 1,
      :description => "MyText"
    ).as_new_record)
  end

  it "renders new criterium form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => criteria_path, :method => "post" do
      assert_select "input#criterium_name", :name => "criterium[name]"
      assert_select "input#criterium_ruberic_id", :name => "criterium[ruberic_id]"
      assert_select "textarea#criterium_description", :name => "criterium[description]"
    end
  end
end
