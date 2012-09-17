class ScoreLevelsController < ApplicationController

    before_filter :ensure_staff?

  def index
    @score_levels = ScoreLevel.all

    respond_to do |format|
      format.html 
      format.json { render json: @score_levels }
    end
  end

  def show
    @score_level = ScoreLevel.find(params[:id])

    respond_to do |format|
      format.html 
      format.json { render json: @score_level }
    end
  end

  def new
    @score_level = ScoreLevel.new
    @users = current_course.users.students
    @assignments = current_course.assignments.all
    @assignment_types = current_course.assignment_types
    respond_to do |format|
      format.html 
      format.json { render json: @score_level }
    end
  end

  def edit
    @score_level = current_course.score_levels.find(params[:id])
    @users = current_course.users.students
  end

  def create
    @score_level = ScoreLevel.new(params[:score_level])
    respond_to do |format|
      if @score_level.save
        format.html { redirect_to @score_level, notice: 'Score Level was successfully created.' }
        format.json { render json: @score_level, status: :created, location: @score_level }
      else
        format.html { render action: "new" }
        format.json { render json: @score_level.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @score_level = current_course.score_levels.find(params[:id])
    @score_level.update_attributes(params[:score_level])

    respond_to do |format|
      if @score_level.update_attributes(params[:score_level])
        format.html { redirect_to @score_level, notice: 'Score Level was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @score_level.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @score_level = ScoreLevel.find(params[:id])
    @score_level.destroy

    respond_to do |format|
      format.html { redirect_to assignment_url(@assignment) }
      format.json { head :ok }
    end
  end
end