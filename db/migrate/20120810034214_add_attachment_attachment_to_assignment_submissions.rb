class AddAttachmentAttachmentToAssignmentSubmissions < ActiveRecord::Migration
  def self.up
    change_table :assignment_submissions do |t|
      t.has_attached_file :attachment
    end
  end

  def self.down
    drop_attached_file :assignment_submissions, :attachment
  end
end
