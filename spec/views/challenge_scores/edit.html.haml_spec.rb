require 'spec_helper'

describe "challenge_scores/edit.html.haml" do
  before(:each) do
    @challenge_score = assign(:challenge_score, stub_model(ChallengeScore,
      :score => 1,
      :feedback => "MyString",
      :team_id => 1,
      :challenge_id => 1
    ))
  end

  it "renders the edit challenge_score form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => challenge_scores_path(@challenge_score), :method => "post" do
      assert_select "input#challenge_score_score", :name => "challenge_score[score]"
      assert_select "input#challenge_score_feedback", :name => "challenge_score[feedback]"
      assert_select "input#challenge_score_team_id", :name => "challenge_score[team_id]"
      assert_select "input#challenge_score_challenge_id", :name => "challenge_score[challenge_id]"
    end
  end
end
