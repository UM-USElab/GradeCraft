require 'spec_helper'

describe "themes/new" do
  before(:each) do
    assign(:theme, stub_model(Theme,
      :name => "MyString",
      :filename => "MyString"
    ).as_new_record)
  end

  it "renders new theme form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => themes_path, :method => "post" do
      assert_select "input#theme_name", :name => "theme[name]"
      assert_select "input#theme_filename", :name => "theme[filename]"
    end
  end
end
