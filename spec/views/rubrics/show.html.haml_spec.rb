require 'spec_helper'

describe "rubrics/show" do
  before(:each) do
    @rubric = assign(:rubric, stub_model(Rubric,
      :name => "Name",
      :assignment_id => 1,
      :description => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/1/)
    rendered.should match(/MyText/)
  end
end
