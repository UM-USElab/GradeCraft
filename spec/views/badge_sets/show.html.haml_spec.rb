require 'spec_helper'

describe "badge_sets/show" do
  before(:each) do
    @badge_set = assign(:badge_set, stub_model(BadgeSet,
      :name => "Name",
      :notes => "Notes"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/Notes/)
  end
end
