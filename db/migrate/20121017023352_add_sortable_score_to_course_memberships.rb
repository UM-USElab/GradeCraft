class AddSortableScoreToCourseMemberships < ActiveRecord::Migration
  def change
    add_column :course_memberships, :sortable_score, :integer
  end
end
