class AddResultsToRankings < ActiveRecord::Migration
  def change
    add_column :rankings, :results, :hstore
  end
end
