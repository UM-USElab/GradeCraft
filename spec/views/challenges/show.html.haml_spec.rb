require 'spec_helper'

describe "challenges/show" do
  before(:each) do
    @challenge = assign(:challenge, stub_model(Challenge,
      :name => "Name",
      :description => "Description",
      :point_total => 1,
      :course_id => 2,
      :points_predictor_display => "Points Predictor Display",
      :visible => false,
      :has_challenge_submissions => false,
      :release_necessary => false
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/Description/)
    rendered.should match(/1/)
    rendered.should match(/2/)
    rendered.should match(/Points Predictor Display/)
    rendered.should match(/false/)
    rendered.should match(/false/)
    rendered.should match(/false/)
  end
end
