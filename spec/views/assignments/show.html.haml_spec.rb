require 'spec_helper'

describe "assignments/show.html.haml" do
  before(:each) do
    @assignment = assign(:assignment, stub_model(Assignment,
      :title => "Title",
      :description => "Description",
      :point_total => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Title/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Description/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
  end
end
