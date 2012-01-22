class ChallengeScoresController < ApplicationController
  # GET /challenge_scores
  # GET /challenge_scores.json
  def index
    @challenge_scores = ChallengeScore.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @challenge_scores }
    end
  end

  # GET /challenge_scores/1
  # GET /challenge_scores/1.json
  def show
    @challenge_score = ChallengeScore.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @challenge_score }
    end
  end

  # GET /challenge_scores/new
  # GET /challenge_scores/new.json
  def new
    @challenge_score = ChallengeScore.new
    @teams = Team.all
    @challenges = Challenge.all
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @challenge_score }
    end
  end

  # GET /challenge_scores/1/edit
  def edit
    @challenge_score = ChallengeScore.find(params[:id])
  end

  # POST /challenge_scores
  # POST /challenge_scores.json
  def create
    @challenge_score = ChallengeScore.new(params[:challenge_score])

    respond_to do |format|
      if @challenge_score.save
        format.html { redirect_to @challenge_score, notice: 'Challenge score was successfully created.' }
        format.json { render json: @challenge_score, status: :created, location: @challenge_score }
      else
        format.html { render action: "new" }
        format.json { render json: @challenge_score.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /challenge_scores/1
  # PUT /challenge_scores/1.json
  def update
    @challenge_score = ChallengeScore.find(params[:id])

    respond_to do |format|
      if @challenge_score.update_attributes(params[:challenge_score])
        format.html { redirect_to @challenge_score, notice: 'Challenge score was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @challenge_score.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /challenge_scores/1
  # DELETE /challenge_scores/1.json
  def destroy
    @challenge_score = ChallengeScore.find(params[:id])
    @challenge_score.destroy

    respond_to do |format|
      format.html { redirect_to challenge_scores_url }
      format.json { head :ok }
    end
  end
end
