class AddTeamTermSettingToCourses < ActiveRecord::Migration
  def up 
    add_column :courses, :team_term, :string
  end
  
  def down 
    remove_column :courses, :team_term
  end
end
