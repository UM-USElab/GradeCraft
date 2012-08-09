class GroupMembershipsController < ApplicationController
  def index
    @group_memberships = GroupMembership.all
    respond_with(@group_memberships)
  end

  def show
    @group_membership = GroupMembership.find(params[:id])
    respond_with(@group_membership)
  end

  def new
    @group_membership = GroupMembership.new
    respond_with(@group_membership)
  end

  def edit
    @group_membership = GroupMembership.find(params[:id])
  end

  def create
    @group_membership = GroupMembership.new(params[:group_membership])
    @group_membership.save
    respond_with(@group_membership)
  end

  def update
    @group_membership = GroupMembership.find(params[:id])
    @group_membership.update_attributes(params[:group_membership])
    respond_with(@group_membership)
  end

  def destroy
    @group_membership = GroupMembership.find(params[:id])
    @group_membership.destroy
    respond_with(@group_membership)
  end
end
