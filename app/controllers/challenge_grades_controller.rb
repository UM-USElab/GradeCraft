class ChallengeGradesController < ApplicationController
  def index
    @challenge_grades = ChallengeGrade.all
    respond_with(@challenge_grades)
  end

  def show
    @challenge_grade = ChallengeGrade.find(params[:id])
    respond_with(@challenge_grade)
  end

  def new
    @challenge_grade = ChallengeGrade.new
    respond_with(@challenge_grade)
  end

  def edit
    @challenge_grade = ChallengeGrade.find(params[:id])
  end

  def create
    @challenge_grade = ChallengeGrade.new(params[:challenge_grade])
    @challenge_grade.save
    respond_with(@challenge_grade)
  end

  def update
    @challenge_grade = ChallengeGrade.find(params[:id])
    @challenge_grade.update_attributes(params[:challenge_grade])
    respond_with(@challenge_grade)
  end

  def destroy
    @challenge_grade = ChallengeGrade.find(params[:id])
    @challenge_grade.destroy
    respond_with(@challenge_grade)
  end
end
