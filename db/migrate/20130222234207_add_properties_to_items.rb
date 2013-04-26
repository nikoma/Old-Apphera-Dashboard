class AddPropertiesToItems < ActiveRecord::Migration
  def change
    add_column :items, :properties, :hstore
  end
end
