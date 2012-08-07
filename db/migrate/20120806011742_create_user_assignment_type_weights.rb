class CreateUserAssignmentTypeWeights < ActiveRecord::Migration
  def change
    create_table :user_assignment_type_weights do |t|

      t.timestamps
    end
  end
end
