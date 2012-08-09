class AddPolymorphicToGrades < ActiveRecord::Migration
  def change
    add_column :grades, :graded_id, :integer
    add_column :grades, :graded_type, :string
    
    add_index :grades, [:graded_id, :graded_type]
  end
end
