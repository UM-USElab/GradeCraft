class EarnedBadgesController < ApplicationController

  before_filter :ensure_staff?

  def index
    @title = "Awarded Badges"
    @user = User.find(params[:user_id])
    @earned_badges = @user.earned_badges
    #@grades = @assignment.assignment_grades.where(params[:assignment_id])
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @earned_badge }
    end
  end

  def show
    @title = "Awarded Badge"
    @earned_badge = EarnedBadge.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @earned_badge }
    end
  end

  def new
    @title = "Award a New Badge"
    @assignments = current_course.assignments.all
    @earned_badge = EarnedBadge.new
    @earned_badge.earnable = params[:earnable_type].constantize.find(params[:earnable_id])    
    @badges = current_course.badges.all
    @students = current_course.users.students.all
  end
  
  def edit
    @title = "Edit Awarded Badge"
    @badges = current_course.badges.all
    @badge_sets = current_course.badge_sets.all
    @students = current_course.users.students.all
    @earned_badge = EarnedBadge.find(params[:id])
    respond_with @earned_badge
  end
  

  def create
    @earnable = find_earnable
    @badge_sets = current_course.badge_sets.all 
    @badges = current_course.badges.all
    @earned_badge = EarnedBadge.new(params[:earned_badge])
    respond_to do |format|
      if @earned_badge.save
        format.html { redirect_to users_path(@earnable.id), notice: 'Badge was successfully awarded.' }
        format.json { render json: @earnable, status: :created, location: @earnable}
      else
        format.html { render action: "new" }
        format.json { render json: @earned_badge.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @earnable = find_earnable
    @badge_sets = current_course.badge_sets.all 
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

  def destroy
    @earned_badge = EarnedBadge.find(params[:id])
    @earned_badge.destroy

    respond_to do |format|
      format.html { redirect_to earned_badges_url }
      format.json { head :ok }
    end
  end
  
    
  def find_earnable
    params.each do |name, value|
      if name =~ /(.+)_id$/
        return $1.classify.constantize.find(value)
      end
    end
    nil
  end

end
