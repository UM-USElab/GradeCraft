class ChangeRubericInCriteria < ActiveRecord::Migration
  def up
    rename_column :criteria, :ruberic_id, :rubric_id
  end

  def down
  end
end
