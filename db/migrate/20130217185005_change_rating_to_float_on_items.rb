class ChangeRatingToFloatOnItems < ActiveRecord::Migration
  def up
    change_column :items, :rating, :float

  end

  def down
    change_column :items, :rating, :decimal

  end
end
