require 'spec_helper'

describe "user_grade_weights/index" do
  before(:each) do
    assign(:user_grade_weights, [
      stub_model(UserGradeWeight),
      stub_model(UserGradeWeight)
    ])
  end

  it "renders a list of user_grade_weights" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
