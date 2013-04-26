class AddIndexToPropertiesOnItems < ActiveRecord::Migration
  def change
    execute "CREATE INDEX items_properties ON items USING GIN(properties)"
  end
end
