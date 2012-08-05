class EarnedBadgesController < ApplicationController
  def index
    @title = "View All Awarded Badges"
    @earned = find_earned
    @earned_badges = current_course.earned_badges.all
    @users = current_course.users.all
    @assignments = current_course.assignments.all
    @grades = current_course.grades.all
    @badges = current_course.badges.all
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @earned_badge }
    end
  end

  # GET /badges/1
  # GET /badges/1.json
  def show
    @title = "Awarded Badge"
    @earned_badge = EarnedBadge.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @earned_badge }
    end
  end

  # GET /badges/new
  # GET /badges/new.json
  def new
    @title = "Award a New Badge"
    @earned_badge = EarnedBadge.new
    @badges = current_course.badges
    @users = current_course.users.students
    @grades = current_user.grades
    @badge_sets = BadgeSet.all
    @earned_badge.user = User.students.find(params[:user_id]) if params[:user_id]
    respond_with @earned_badge
  end

  # GET /badges/1/edit
  def edit
    @title = "Edit Awarded Badge"
    @badges = Badge.all
    @badge_sets = BadgeSet.all
    @earned_badge.user = User.students.find(params[:user_id]) if params[:user_id]
    @earned_badge = EarnedBadge.find(params[:id])
  end

  # POST /badges
  # POST /badges.json
  def create
    @earned = find_earned
    @earned = @earned.earned_badges.build(params[:earned_badge])
    @badge_sets = BadgeSet.all
    @badges = Badge.all
    @earned_badge = EarnedBadge.new(params[:earned_badge])

    respond_to do |format|
      if @earned_badge.save
        format.html { redirect_to @earned_badge, notice: 'Badge was successfully awarded.' }
        format.json { render json: @earned_badge, status: :created, location: @earned_badge }
      else
        format.html { render action: "new" }
        format.json { render json: @earned_badge.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /badges/1
  # PUT /badges/1.json
  def update
    @badge_sets = BadgeSet.all
    @badges = Badge.all
    @earned_badge = EarnedBadge.find(params[:id])

    respond_to do |format|
      if @earned_badge.update_attributes(params[:earned_badge])
        format.html { redirect_to @earned_badge, notice: 'Awarded badge was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @earned_badge.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /badges/1
  # DELETE /badges/1.json
  def destroy
    @earned_badge = EarnedBadge.find(params[:id])
    @earned_badge.destroy

    respond_to do |format|
      format.html { redirect_to earned_badges_url }
      format.json { head :ok }
    end
  end
  
  def find_earned
    params.each do |name, value|
      if name =~ /(.+)_id$/
        return $1.classify.constantize.find(value)
      end
    end
    nil
  end
end