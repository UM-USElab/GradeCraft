require 'spec_helper'

describe "dashboards/edit.html.haml" do
  before(:each) do
    @dashboard = assign(:dashboard, stub_model(Dashboard))
  end

  it "renders the edit dashboard form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => dashboards_path(@dashboard), :method => "post" do
    end
  end
end
