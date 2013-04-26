class AddIndexToRankingsResults < ActiveRecord::Migration
  def up
    execute "CREATE INDEX rankings_results ON rankings USING GIN(results)"
  end

  def down
    execute "DROP INDEX rankings_results"
  end
end
