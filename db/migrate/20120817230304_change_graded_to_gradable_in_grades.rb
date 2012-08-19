class ChangeGradedToGradableInGrades < ActiveRecord::Migration
  def change 
    rename_column :grades, :graded_id, :gradeable_id
    rename_column :grades, :graded_type, :gradeable_type
  end
end
