require 'spec_helper'

describe "challenge_scores/index.html.haml" do
  before(:each) do
    assign(:challenge_scores, [
      stub_model(ChallengeScore,
        :score => 1,
        :feedback => "Feedback",
        :team_id => 1,
        :challenge_id => 1
      ),
      stub_model(ChallengeScore,
        :score => 1,
        :feedback => "Feedback",
        :team_id => 1,
        :challenge_id => 1
      )
    ])
  end

  it "renders a list of challenge_scores" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Feedback".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
