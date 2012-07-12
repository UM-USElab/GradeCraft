class AddUserNameToCourses < ActiveRecord::Migration
  def up
    add_column :courses, :user_term, :string
  end

  def down
    remove_column :courses, :user_term
  end
end
