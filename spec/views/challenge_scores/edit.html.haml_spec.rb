require 'spec_helper'

describe "challenge_grades/edit.html.haml" do
  before(:each) do
    @challenge_grade = assign(:challenge_grade, stub_model(ChallengeGrade,
      :score => 1,
      :feedback => "MyString",
      :team_id => 1,
      :challenge_id => 1
    ))
  end

  it "renders the edit challenge_grade form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => challenge_grades_path(@challenge_grade), :method => "post" do
      assert_select "input#challenge_grade_score", :name => "challenge_grade[score]"
      assert_select "input#challenge_grade_feedback", :name => "challenge_grade[feedback]"
      assert_select "input#challenge_grade_team_id", :name => "challenge_grade[team_id]"
      assert_select "input#challenge_grade_challenge_id", :name => "challenge_grade[challenge_id]"
    end
  end
end
