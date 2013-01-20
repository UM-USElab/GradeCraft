require 'spec_helper'

describe "challenge_grades/show" do
  before(:each) do
    @challenge_grade = assign(:challenge_grade, stub_model(ChallengeGrade,
      :challenge_id => 1,
      :score => 2,
      :feedback => "Feedback",
      :status => false,
      :team_id => 3,
      :final_score => 4
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/2/)
    rendered.should match(/Feedback/)
    rendered.should match(/false/)
    rendered.should match(/3/)
    rendered.should match(/4/)
  end
end
