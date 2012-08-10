require 'spec_helper'

describe "assignment_submissions/edit" do
  before(:each) do
    @assignment_submission = assign(:assignment_submission, stub_model(AssignmentSubmission,
      :assignment_id => 1,
      :user_id => 1,
      :group_id => 1,
      :feedback => "MyString",
      :comment => "MyString"
    ))
  end

  it "renders the edit assignment_submission form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => assignment_submissions_path(@assignment_submission), :method => "post" do
      assert_select "input#assignment_submission_assignment_id", :name => "assignment_submission[assignment_id]"
      assert_select "input#assignment_submission_user_id", :name => "assignment_submission[user_id]"
      assert_select "input#assignment_submission_group_id", :name => "assignment_submission[group_id]"
      assert_select "input#assignment_submission_feedback", :name => "assignment_submission[feedback]"
      assert_select "input#assignment_submission_comment", :name => "assignment_submission[comment]"
    end
  end
end
