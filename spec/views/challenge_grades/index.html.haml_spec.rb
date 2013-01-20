require 'spec_helper'

describe "challenge_grades/index" do
  before(:each) do
    assign(:challenge_grades, [
      stub_model(ChallengeGrade,
        :challenge_id => 1,
        :score => 2,
        :feedback => "Feedback",
        :status => false,
        :team_id => 3,
        :final_score => 4
      ),
      stub_model(ChallengeGrade,
        :challenge_id => 1,
        :score => 2,
        :feedback => "Feedback",
        :status => false,
        :team_id => 3,
        :final_score => 4
      )
    ])
  end

  it "renders a list of challenge_grades" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Feedback".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
  end
end
