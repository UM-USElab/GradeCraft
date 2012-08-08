require 'spec_helper'

describe "user_grade_weights/new" do
  before(:each) do
    assign(:user_grade_weight, stub_model(UserGradeWeight).as_new_record)
  end

  it "renders new user_grade_weight form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => user_grade_weights_path, :method => "post" do
    end
  end
end
