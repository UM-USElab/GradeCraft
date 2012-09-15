class CreateScoreLevels < ActiveRecord::Migration
  def change
    create_table :score_levels do |s|
      s.string :name
      s.integer :value
      s.integer :assignment_type_id
      s.integer :assignment_id
      
      s.timestamps
    end
  end

end
