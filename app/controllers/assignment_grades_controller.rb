class AssignmentGradesController < ApplicationController
  respond_to :html, :json

  before_filter :ensure_staff?
  before_filter :set_assignment

  def index
    @grades = @assignment.grades
  end

  def edit
    @grades = User.students.map { |s| @assignment.grades.find_or_create_by_user_id(s.id) }
  end

  def update
    if @assignment.update_attributes(params[:assignment])
      respond_with @assignment, :location => assignment_grades_path
    else
      respond_with @assignment, :location => edit_assignment_grades_path(@assignment)
    end
  end

  protected
  def set_assignment
    @assignment = Assignment.find(params[:assignment_id])
  end
end
