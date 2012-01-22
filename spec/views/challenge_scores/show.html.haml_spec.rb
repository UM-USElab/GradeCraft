require 'spec_helper'

describe "challenge_scores/show.html.haml" do
  before(:each) do
    @challenge_score = assign(:challenge_score, stub_model(ChallengeScore,
      :score => 1,
      :feedback => "Feedback",
      :team_id => 1,
      :challenge_id => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Feedback/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
  end
end
