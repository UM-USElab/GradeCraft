class AddSectionLeaderTermToCourse < ActiveRecord::Migration
  def change
    add_column :courses, :section_leader_term, :string
  end
end
