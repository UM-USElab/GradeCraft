class AddMultiplierTermToCourse < ActiveRecord::Migration
  def change
    add_column :courses, :multiplier_term, :string
  end
end
