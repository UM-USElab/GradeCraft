class SetStudentWeightable < ActiveRecord::Migration
  def up
    AssignmentType.where(:user_percentage_set => 'true').update_all(:student_weightable => true)
  end

  def down
    #noop
  end
end
