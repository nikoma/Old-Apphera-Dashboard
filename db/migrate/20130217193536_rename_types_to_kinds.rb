class RenameTypesToKinds < ActiveRecord::Migration
  def up
   rename_table :types, :kinds
  end

  def down
  end
end
