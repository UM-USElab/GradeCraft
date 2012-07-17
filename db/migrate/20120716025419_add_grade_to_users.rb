class AddGradeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :final_grade, :string
  end
end
