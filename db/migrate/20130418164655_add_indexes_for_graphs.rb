class AddIndexesForGraphs < ActiveRecord::Migration
  def up
    add_index :ambassadors, :created_at
    add_index :points, :created_at
    add_index :posts, :created_at
    add_index :badges, :created_at
  end

  def down
    remove_index :ambassadors, :created_at
    remove_index :points, :created_at
    remove_index :posts, :created_at
    remove_index :badges, :created_at
  end
end
