class AddLinkToASubmission < ActiveRecord::Migration
  def change
    add_column :assignment_submissions, :link, :string
  end
end
