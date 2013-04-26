class ChangeDatatypeFromHstoreToJsonOnRankings < ActiveRecord::Migration
  def up
    add_column :rankings, :ranks, :text
  end

  def down
  end
end
