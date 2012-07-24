require 'spec_helper'

describe "grade_scheme_elements/show" do
  before(:each) do
    @grade_scheme_element = assign(:grade_scheme_element, stub_model(GradeSchemeElement,
      :name => "Name",
      :low_range => 1,
      :high_range => 2,
      :letter_grade => "Letter Grade"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/1/)
    rendered.should match(/2/)
    rendered.should match(/Letter Grade/)
  end
end
