class SwitchStringToText < ActiveRecord::Migration
  def change 
    add_column :assignment_submissions, :text_feedback, :text
    add_column :assignment_submissions, :text_comment, :text
    add_column :earned_badges, :text_feedback, :text
    add_column :groups, :text_proposal, :text
  end
end
