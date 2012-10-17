class EarnedBadgesController < ApplicationController

  before_filter :ensure_staff?
  before_filter :find_earnable

  def index
    @title = "Awarded Badges"
    @earned_badges = @earnable.earned_badges
    respond_to do |format|
      format.html
      format.json { render json: @earned_badge }
    end
  end

  def show
    @title = "Awarded Badge"
    @earned_badge = @earnable.earned_badges.find(params[:id])

    respond_to do |format|
      format.html
      format.json { render json: @earned_badge }
    end
  end

  def new
    @title = "Award a New Badge"
    @assignments = current_course.assignments.all
    @badges = current_course.badges.all
    @earned_badge = @earnable.earned_badges.new
    #@earned_badge.earnable = params[:earnable_type].constantize.find(params[:earnable_id])    
  end
  
  def edit
    @title = "Edit Awarded Badge"
    @badges = current_course.badges.all
    @badge_sets = current_course.badge_sets.all
    @earned_badge = EarnedBadge.find(params[:id])
    respond_with @earned_badge
  end
  

  def create
    @badge_sets = current_course.badge_sets.all 
    @badges = current_course.badges.all
    @earned_badge = @earnable.earned_badges.build(params[:earned_badge])
    respond_to do |format|
      if @earned_badge.save
        format.html { redirect_to @earnable, notice: 'Badge was successfully awarded.' }
        format.json { render json: @earnable, status: :created, location: @earnable}
      else
        format.html { render action: "new" }
        format.json { render json: @earned_badge.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @badge_sets = current_course.badge_sets.all 
    @badges = Badge.all
    @earned_badge = EarnedBadge.find(params[:id])

    respond_to do |format|
      if @earned_badge.update_attributes(params[:earned_badge])
        format.html { redirect_to @earnable, notice: 'Awarded badge was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @earned_badge.errors, status: :unprocessable_entity }
      end
    end
  end
  
  
  def mass_edit
    @badges = Badge.all
    @earned_badge = EarnedBadge.create(params[:earned_badge])
    user_search_options = {}
    user_search_options['team_memberships.team_id'] = params[:team_id] if params[:team_id].present?
    @students = current_course.users.students.includes(:teams).where(user_search_options)
    @earned_badges = @students.map do |s|
      EarnedBadge.where(:earnable_id => s.id, :gradeable_type => 'User').first || EarnedBadge.new(:earnable => s, :earnable_type => "User")
    end
  end
  
  def mass_update
    @earnable = find_earnable
    
    respond_to do |format|
      if @earnable.update_attributes(params[:earned_badge])
      redirect_to chart_earned_badges_path
      else
        redirect_to mass_edit_earned_badges_path(@badge)
      end
    end
  end

  def destroy
    @earned_badge = EarnedBadge.find(params[:id])
    @earned_badge.destroy

    respond_to do |format|
      format.html { redirect_to @earnable }
      format.json { head :ok }
    end
  end
  
    
  def find_earnable
    klass = [User, Grade, Team, Group].detect { |c| params["#{c.name.underscore}_id"]}
    @earnable = klass.find(params["#{klass.name.underscore}_id"])
  end

end
