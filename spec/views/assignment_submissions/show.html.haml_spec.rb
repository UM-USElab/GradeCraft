require 'spec_helper'

describe "assignment_submissions/show" do
  before(:each) do
    @assignment_submission = assign(:assignment_submission, stub_model(AssignmentSubmission,
      :assignment_id => 1,
      :user_id => 2,
      :group_id => 3,
      :feedback => "Feedback",
      :comment => "Comment"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/2/)
    rendered.should match(/3/)
    rendered.should match(/Feedback/)
    rendered.should match(/Comment/)
  end
end
