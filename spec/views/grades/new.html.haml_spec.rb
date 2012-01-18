require 'spec_helper'

describe "grades/new.html.haml" do
  before(:each) do
    assign(:grade, stub_model(Grade,
      :score => 1,
      :user => nil,
      :assignment => nil,
      :feedback => "MyString",
      :badge => nil
    ).as_new_record)
  end

  it "renders new grade form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => grades_path, :method => "post" do
      assert_select "input#grade_score", :name => "grade[score]"
      assert_select "input#grade_user", :name => "grade[user]"
      assert_select "input#grade_assignment", :name => "grade[assignment]"
      assert_select "input#grade_feedback", :name => "grade[feedback]"
      assert_select "input#grade_badge", :name => "grade[badge]"
    end
  end
end
