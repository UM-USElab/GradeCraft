require 'spec_helper'

describe "challenges/edit.html.haml" do
  before(:each) do
    @challenge = assign(:challenge, stub_model(Challenge,
      :title => "MyString",
      :points => 1,
      :team_id => 1,
      :description => "MyString"
    ))
  end

  it "renders the edit challenge form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => challenges_path(@challenge), :method => "post" do
      assert_select "input#challenge_title", :name => "challenge[title]"
      assert_select "input#challenge_points", :name => "challenge[points]"
      assert_select "input#challenge_team_id", :name => "challenge[team_id]"
      assert_select "input#challenge_description", :name => "challenge[description]"
    end
  end
end
