class AddWelcomeToCourse < ActiveRecord::Migration
  def change
    add_column :courses, :homepage_message, :string
  end
end
