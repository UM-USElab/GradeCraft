require 'spec_helper'

describe "teams/new.html.haml" do
  before(:each) do
    assign(:team, stub_model(Team,
      :name => "MyString"
    ).as_new_record)
  end

  it "renders new team form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => teams_path, :method => "post" do
      assert_select "input#team_name", :name => "team[name]"
    end
  end
end
