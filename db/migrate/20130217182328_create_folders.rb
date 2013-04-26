class CreateFolders < ActiveRecord::Migration
  def change
    create_table :folders do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
    add_index :folders, :name
  end
end
