class ChangeLevelsToBooleanATypes < ActiveRecord::Migration
  def up
    change_column :assignment_types, :levels, :boolean
  end
end
