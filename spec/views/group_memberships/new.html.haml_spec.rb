require 'spec_helper'

describe "group_memberships/new" do
  before(:each) do
    assign(:group_membership, stub_model(GroupMembership,
      :group_id => 1,
      :user_id => 1,
      :accepted => "MyString"
    ).as_new_record)
  end

  it "renders new group_membership form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => group_memberships_path, :method => "post" do
      assert_select "input#group_membership_group_id", :name => "group_membership[group_id]"
      assert_select "input#group_membership_user_id", :name => "group_membership[user_id]"
      assert_select "input#group_membership_accepted", :name => "group_membership[accepted]"
    end
  end
end
