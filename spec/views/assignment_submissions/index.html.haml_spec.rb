require 'spec_helper'

describe "assignment_submissions/index" do
  before(:each) do
    assign(:assignment_submissions, [
      stub_model(AssignmentSubmission,
        :assignment_id => 1,
        :user_id => 2,
        :group_id => 3,
        :feedback => "Feedback",
        :comment => "Comment"
      ),
      stub_model(AssignmentSubmission,
        :assignment_id => 1,
        :user_id => 2,
        :group_id => 3,
        :feedback => "Feedback",
        :comment => "Comment"
      )
    ])
  end

  it "renders a list of assignment_submissions" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => "Feedback".to_s, :count => 2
    assert_select "tr>td", :text => "Comment".to_s, :count => 2
  end
end
