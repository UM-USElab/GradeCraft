require 'spec_helper'

describe "grades/edit.html.haml" do
  before(:each) do
    @grade = assign(:grade, stub_model(Grade,
      :score => 1,
      :user => nil,
      :assignment => nil,
      :feedback => "MyString",
      :badge => nil
    ))
  end

  it "renders the edit grade form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => grades_path(@grade), :method => "post" do
      assert_select "input#grade_score", :name => "grade[score]"
      assert_select "input#grade_user", :name => "grade[user]"
      assert_select "input#grade_assignment", :name => "grade[assignment]"
      assert_select "input#grade_feedback", :name => "grade[feedback]"
      assert_select "input#grade_badge", :name => "grade[badge]"
    end
  end
end
