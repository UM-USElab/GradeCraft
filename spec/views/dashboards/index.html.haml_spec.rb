require 'spec_helper'

describe "dashboards/index.html.haml" do
  before(:each) do
    assign(:dashboards, [
      stub_model(Dashboard),
      stub_model(Dashboard)
    ])
  end

  it "renders a list of dashboards" do
    render
  end
end
