class CreateDashboards < ActiveRecord::Migration
  def change
    create_table :dashboards do |t|

      t.timestamps
    end
  end
end
