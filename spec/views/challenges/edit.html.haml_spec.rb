require 'spec_helper'

describe "challenges/edit" do
  before(:each) do
    @challenge = assign(:challenge, stub_model(Challenge,
      :name => "MyString",
      :description => "MyString",
      :point_total => 1,
      :course_id => 1,
      :points_predictor_display => "MyString",
      :visible => false,
      :has_challenge_submissions => false,
      :release_necessary => false
    ))
  end

  it "renders the edit challenge form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => challenges_path(@challenge), :method => "post" do
      assert_select "input#challenge_name", :name => "challenge[name]"
      assert_select "input#challenge_description", :name => "challenge[description]"
      assert_select "input#challenge_point_total", :name => "challenge[point_total]"
      assert_select "input#challenge_course_id", :name => "challenge[course_id]"
      assert_select "input#challenge_points_predictor_display", :name => "challenge[points_predictor_display]"
      assert_select "input#challenge_visible", :name => "challenge[visible]"
      assert_select "input#challenge_has_challenge_submissions", :name => "challenge[has_challenge_submissions]"
      assert_select "input#challenge_release_necessary", :name => "challenge[release_necessary]"
    end
  end
end
