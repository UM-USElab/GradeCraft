class GroupsController < ApplicationController

  def index
    @title = "View All Groups"
    @groups = current_course.groups

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @groups }
    end
  end

  def show
    @title = "View Group"
    @group = current_course.groups.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @group }
    end
  end

  def new
    @title = "Create a New Group"
    @group = current_course.groups.new
    @users = current_course.users.students
    @assignments = current_course.assignments.all
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @group }
    end
  end

  def edit
    @title = "Edit Group"
    @group = current_course.groups.find(params[:id])
    @users = current_course.users.students
  end

  def create
    @group = current_course.groups.new(params[:group])
    respond_to do |format|
      if @group.save
        format.html { redirect_to @group, notice: 'Group was successfully created.' }
        format.json { render json: @group, status: :created, location: @group }
      else
        format.html { render action: "new" }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @group = current_course.groups.find(params[:id])
    @group.update_attributes(params[:group])

    respond_to do |format|
      if @group.update_attributes(params[:group])
        format.html { redirect_to @group, notice: 'Group was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @group = current_course.groups.find(params[:id])
    @group.destroy

    respond_to do |format|
      format.html { redirect_to groups_url }
      format.json { head :ok }
    end
  end
end
