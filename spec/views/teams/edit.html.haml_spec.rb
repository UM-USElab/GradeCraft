require 'spec_helper'

describe "teams/edit.html.haml" do
  before(:each) do
    @team = assign(:team, stub_model(Team,
      :name => "MyString"
    ))
  end

  it "renders the edit team form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => teams_path(@team), :method => "post" do
      assert_select "input#team_name", :name => "team[name]"
    end
  end
end
