class RenameKindToKindIdOnItems < ActiveRecord::Migration
  def up
    rename_column :items, :kind, :kind_id
  end

  def down
  end
end
