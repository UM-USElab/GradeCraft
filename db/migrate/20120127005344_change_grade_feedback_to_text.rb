class ChangeGradeFeedbackToText < ActiveRecord::Migration
  def up
    change_column :grades, :feedback, :text
  end

  def down
    change_column :grades, :feedback, :string
  end
end
