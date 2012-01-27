class GradesController < ApplicationController

  before_filter :ensure_staff?, :only=>[:index,:new,:edit,:create,:update,:destroy]

  helper_method :sort_column, :sort_direction

  # GET /grades
  # GET /grades.json
  def index
    @title = "View All Grades"
    @grades = Grade.find(:all, :order => (sort_column + " " + sort_direction))
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @grades }
    end
  end

  # GET /grades/1
  # GET /grades/1.json
  def show
    @title = "View Grade"
    @grade = Grade.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @grade }
    end
  end

  # GET /grades/new
  # GET /grades/new.json
  def new
    @title = "Submit New Grade"
    @grade = Grade.new
    @users = User.all
    @badges = Badge.all
    @teams = Team.all

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @grade }
    end
  end

  # GET /grades/1/edit
  def edit
    @title = "Edit Grade"
    @grade = Grade.find(params[:id])
  end

  # POST /grades
  # POST /grades.json
  def create
    @grade = Grade.new(params[:grade])
    @users = User.all
    @badges = Badge.all
    @teams = Team.all

    respond_to do |format|
      if @grade.save
        format.html { redirect_to @grade, notice: 'Grade was successfully created.' }
        format.json { render json: @grade, status: :created, location: @grade }
      else
        format.html { render action: "new" }
        format.json { render json: @grade.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /grades/1
  # PUT /grades/1.json
  def update
    @grade = Grade.find(params[:id])

    respond_to do |format|
      if @grade.update_attributes(params[:grade])
        format.html { redirect_to @grade, notice: 'Grade was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @grade.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /grades/1
  # DELETE /grades/1.json
  def destroy
    @grade = Grade.find(params[:id])
    @grade.destroy

    respond_to do |format|
      format.html { redirect_to grades_url }
      format.json { head :ok }
    end
  end
  
  def mass_new 
  end
  
  def mass_create
  end
  
  def sort_column
    Grade.column_names.include?(params[:sort]) ? params[:sort] : "assignment_id"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

end
