class CourseMembership < ActiveRecord::Base
  
  belongs_to :course
  belongs_to :user
  
  def destroy
    @course_membership = current_course.course_memberships.find(params[:id])    
    @course_membership.destroy

    respond_to do |format|
      format.html { redirect_to users }
      format.json { head :ok }
    end
  end
  
end