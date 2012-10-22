class GroupsController < ApplicationController

  before_filter :ensure_staff?

  def index
    #@assignment = Assignment.find(params[:assignment_id])
    @groups = Group.all
 
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @groups }
    end
  end

  def show
    @assignment = Assignment.find(params[:assignment_id])
    @group = Group.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @group }
    end
  end

  def new
    @assignment = Assignment.find(params[:assignment_id])
    @group = @assignment.groups.new
    @students = current_course.users.students
    @assignments = current_course.assignments.all
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @group }
    end
  end

  def edit
    @title = "Edit Group"
    @assignment = Assignment.find(params[:assignment_id])
    @group = @assignment.groups.find(params[:id])
    @students = current_course.users.students
  end

  def create
    @assignment = Assignment.find(params[:assignment_id])
    @group = @assignment.groups.build(params[:group])
    respond_to do |format|
      if @group.save
        format.html { redirect_to assignment_path(@assignment), notice: 'Group was successfully created.' }
        format.json { render json: @group, status: :created, location: @group }
      else
        format.html { render action: "new" }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @assignment = Assignment.find(params[:assignment_id])
    @group = Group.find(params[:id])
    @group.update_attributes(params[:group])

    respond_to do |format|
      if @group.update_attributes(params[:group])
        format.html { redirect_to assignment_group_path(@assignment, @group), notice: 'Group was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @assignment = Assignment.find(params[:assignment_id])
    @group = Group.find(params[:id])
    @group.destroy

    respond_to do |format|
      format.html { redirect_to assignment_path(@assignment) }
      format.json { head :ok }
    end
  end
end
