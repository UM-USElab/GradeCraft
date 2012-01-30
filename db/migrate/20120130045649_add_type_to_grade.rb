class AddTypeToGrade < ActiveRecord::Migration
  def up
    add_column :grades, :type, :string
  end
end
