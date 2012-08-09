require 'spec_helper'

describe "group_memberships/index" do
  before(:each) do
    assign(:group_memberships, [
      stub_model(GroupMembership,
        :group_id => 1,
        :user_id => 2,
        :accepted => "Accepted"
      ),
      stub_model(GroupMembership,
        :group_id => 1,
        :user_id => 2,
        :accepted => "Accepted"
      )
    ])
  end

  it "renders a list of group_memberships" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Accepted".to_s, :count => 2
  end
end
