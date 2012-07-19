class ChallengeGradesController < ApplicationController
  # GET /challenge_grades
  # GET /challenge_grades.json
  def index
    @title = "Team Challenge Grades"
    @challenge_grades = current_course.challenge_grades.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @challenge_grades }
    end
  end

  # GET /challenge_grades/1
  # GET /challenge_grades/1.json
  def show
    @title = "View Team Challenge Score"
    respond_with @challenge_grade = current_course.challenge_grades.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @challenge_grade }
    end
  end

  # GET /challenge_grades/new
  # GET /challenge_grades/new.json
  def new
    @title = "Grade a Team Challenge"
    @challenge_grade = current_course.challenge_grades.new
    @teams = Team.all
    @challenges = Challenge.all
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @challenge_grade }
    end
  end

  # GET /challenge_grades/1/edit
  def edit
    @title = "Edit a Team Challenge Score"
    @teams = Team.all
    @challenges = Challenge.all
    @challenge_grade = ChallengeGrade.find(params[:id])
  end

  # POST /challenge_grades
  # POST /challenge_grades.json
  def create
    @challenge_grade = ChallengeGrade.new(params[:challenge_grade])

    respond_to do |format|
      if @challenge_grade.save
        format.html { redirect_to @challenge_grade, notice: 'Challenge score was successfully created.' }
        format.json { render json: @challenge_grade, status: :created, location: @challenge_grade }
      else
        format.html { render action: "new" }
        format.json { render json: @challenge_grade.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /challenge_grades/1
  # PUT /challenge_grades/1.json
  def update
    @challenge_grade = ChallengeGrade.find(params[:id])

    respond_to do |format|
      if @challenge_grade.update_attributes(params[:challenge_grade])
        format.html { redirect_to @challenge_grade, notice: 'Challenge score was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @challenge_grade.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /challenge_grades/1
  # DELETE /challenge_grades/1.json
  def destroy
    @challenge_grade = ChallengeGrade.find(params[:id])
    @challenge_grade.destroy

    respond_to do |format|
      format.html { redirect_to challenge_grades_url }
      format.json { head :ok }
    end
  end
end
