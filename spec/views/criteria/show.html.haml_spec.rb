require 'spec_helper'

describe "criteria/show" do
  before(:each) do
    @criterium = assign(:criterium, stub_model(Criterium,
      :name => "Name",
      :ruberic_id => 1,
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
