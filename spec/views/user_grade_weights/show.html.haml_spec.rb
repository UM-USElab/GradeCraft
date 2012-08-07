require 'spec_helper'

describe "user_grade_weights/show" do
  before(:each) do
    @user_grade_weight = assign(:user_grade_weight, stub_model(UserGradeWeight))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
