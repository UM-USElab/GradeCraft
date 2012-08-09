require 'spec_helper'

describe "group_memberships/show" do
  before(:each) do
    @group_membership = assign(:group_membership, stub_model(GroupMembership,
      :group_id => 1,
      :user_id => 2,
      :accepted => "Accepted"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/2/)
    rendered.should match(/Accepted/)
  end
end
