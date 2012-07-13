require 'spec_helper'

describe "themes/show" do
  before(:each) do
    @theme = assign(:theme, stub_model(Theme,
      :name => "Name",
      :filename => "Filename"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/Filename/)
  end
end
