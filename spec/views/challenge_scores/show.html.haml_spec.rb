require 'spec_helper'

describe "challenge_grades/show.html.haml" do
  before(:each) do
    @challenge_grade = assign(:challenge_grade, stub_model(ChallengeGrade,
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
