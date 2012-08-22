class AddGroupTermToCourse < ActiveRecord::Migration
  def change
    add_column :courses, :group_term, :string
  end
end
