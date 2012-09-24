class AddPredictorSettingtoCourses < ActiveRecord::Migration
  def change
    add_column :courses, :predictor_setting, :boolean
    add_column :courses, :badges_value, :boolean
  end
end
