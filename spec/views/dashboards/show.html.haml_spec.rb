require 'spec_helper'

describe "dashboards/show.html.haml" do
  before(:each) do
    @dashboard = assign(:dashboard, stub_model(Dashboard))
  end

  it "renders attributes in <p>" do
    render
  end
end
