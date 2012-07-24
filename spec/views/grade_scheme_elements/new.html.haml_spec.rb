require 'spec_helper'

describe "grade_scheme_elements/new" do
  before(:each) do
    assign(:grade_scheme_element, stub_model(GradeSchemeElement,
      :name => "MyString",
      :low_range => 1,
      :high_range => 1,
      :letter_grade => "MyString"
    ).as_new_record)
  end

  it "renders new grade_scheme_element form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => grade_scheme_elements_path, :method => "post" do
      assert_select "input#grade_scheme_element_name", :name => "grade_scheme_element[name]"
      assert_select "input#grade_scheme_element_low_range", :name => "grade_scheme_element[low_range]"
      assert_select "input#grade_scheme_element_high_range", :name => "grade_scheme_element[high_range]"
      assert_select "input#grade_scheme_element_letter_grade", :name => "grade_scheme_element[letter_grade]"
    end
  end
end
