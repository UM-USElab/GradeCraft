class AddDateToUserPercentagesInCourses < ActiveRecord::Migration
  def change
    add_column :courses, :user_weight_amount_close_date, :datetime
  end
end
