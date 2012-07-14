class CreateAssignmentTypes < ActiveRecord::Migration
  def change
    create_table :assignment_types do |t|
      t.string :name
      t.string :point_setting
      t.integer :levels
      t.string :points_predictor_display
      t.datetime :due_date
      t.integer :resubmission
      t.integer :max_value
      t.integer :percentage_course
      t.string :predictor_description

      t.timestamps
    end
  end
end
