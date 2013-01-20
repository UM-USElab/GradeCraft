require 'spec_helper'

describe "challenge_grades/new" do
  before(:each) do
    assign(:challenge_grade, stub_model(ChallengeGrade,
      :challenge_id => 1,
      :score => 1,
      :feedback => "MyString",
      :status => false,
      :team_id => 1,
      :final_score => 1
    ).as_new_record)
  end

  it "renders new challenge_grade form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => challenge_grades_path, :method => "post" do
      assert_select "input#challenge_grade_challenge_id", :name => "challenge_grade[challenge_id]"
      assert_select "input#challenge_grade_score", :name => "challenge_grade[score]"
      assert_select "input#challenge_grade_feedback", :name => "challenge_grade[feedback]"
      assert_select "input#challenge_grade_status", :name => "challenge_grade[status]"
      assert_select "input#challenge_grade_team_id", :name => "challenge_grade[team_id]"
      assert_select "input#challenge_grade_final_score", :name => "challenge_grade[final_score]"
    end
  end
end
