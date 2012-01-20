require 'spec_helper'

describe "dashboards/new.html.haml" do
  before(:each) do
    assign(:dashboard, stub_model(Dashboard).as_new_record)
  end

  it "renders new dashboard form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => dashboards_path, :method => "post" do
    end
  end
end
