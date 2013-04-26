class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :subject
      t.text :body
      t.decimal :rating
      t.integer :type
      t.integer :folder
      t.boolean :visible
      t.integer :source
      t.datetime :reminder
      t.boolean :new
      t.integer :organization_id
      t.integer :reviewer_id
      t.boolean :completed

      t.timestamps
    end
    add_index :items, :type
    add_index :items, :folder
    add_index :items, :visible
    add_index :items, :source
    add_index :items, :organization_id
    add_index :items, :reviewer_id
    add_index :items, :completed
  end
end
