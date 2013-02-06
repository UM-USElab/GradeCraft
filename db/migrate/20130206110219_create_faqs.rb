class CreateFaqs < ActiveRecord::Migration
  def change
    create_table :faqs do |t|
      t.string :question
      t.text :answer
      t.integer :order
      t.string :category
      t.string :audience

      t.timestamps
    end
  end
end
