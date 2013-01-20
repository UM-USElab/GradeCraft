require 'spec_helper'

describe "challenges/index" do
  before(:each) do
    assign(:challenges, [
      stub_model(Challenge,
        :name => "Name",
        :description => "Description",
        :point_total => 1,
        :course_id => 2,
        :points_predictor_display => "Points Predictor Display",
        :visible => false,
        :has_challenge_submissions => false,
        :release_necessary => false
      ),
      stub_model(Challenge,
        :name => "Name",
        :description => "Description",
        :point_total => 1,
        :course_id => 2,
        :points_predictor_display => "Points Predictor Display",
        :visible => false,
        :has_challenge_submissions => false,
        :release_necessary => false
      )
    ])
  end

  it "renders a list of challenges" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Description".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Points Predictor Display".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
