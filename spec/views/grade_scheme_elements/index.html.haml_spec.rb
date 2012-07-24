require 'spec_helper'

describe "grade_scheme_elements/index" do
  before(:each) do
    assign(:grade_scheme_elements, [
      stub_model(GradeSchemeElement,
        :name => "Name",
        :low_range => 1,
        :high_range => 2,
        :letter_grade => "Letter Grade"
      ),
      stub_model(GradeSchemeElement,
        :name => "Name",
        :low_range => 1,
        :high_range => 2,
        :letter_grade => "Letter Grade"
      )
    ])
  end

  it "renders a list of grade_scheme_elements" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Letter Grade".to_s, :count => 2
  end
end
