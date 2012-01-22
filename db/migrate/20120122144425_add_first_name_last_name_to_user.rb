class AddFirstNameLastNameToUser < ActiveRecord::Migration
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
  end  
  
  def self.down
    remove_column :users, :first_name, :string
    remove_columN :users, :last_name, :string
  end
end
