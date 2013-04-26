class RenameTypeToKindOnItems < ActiveRecord::Migration
  def up
    rename_column :items, :type, :kind
  end

  def down
  end
end
