require 'spec_helper'

describe "user_grade_weights/edit" do
  before(:each) do
    @user_grade_weight = assign(:user_grade_weight, stub_model(UserGradeWeight))
  end

  it "renders the edit user_grade_weight form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => user_grade_weights_path(@user_grade_weight), :method => "post" do
    end
  end
end
