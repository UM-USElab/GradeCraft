require 'spec_helper'

describe "grade_scheme_elements/edit" do
  before(:each) do
    @grade_scheme_element = assign(:grade_scheme_element, stub_model(GradeSchemeElement,
      :name => "MyString",
      :low_range => 1,
      :high_range => 1,
      :letter_grade => "MyString"
    ))
  end

  it "renders the edit grade_scheme_element form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => grade_scheme_elements_path(@grade_scheme_element), :method => "post" do
      assert_select "input#grade_scheme_element_name", :name => "grade_scheme_element[name]"
      assert_select "input#grade_scheme_element_low_range", :name => "grade_scheme_element[low_range]"
      assert_select "input#grade_scheme_element_high_range", :name => "grade_scheme_element[high_range]"
      assert_select "input#grade_scheme_element_letter_grade", :name => "grade_scheme_element[letter_grade]"
    end
  end
end
