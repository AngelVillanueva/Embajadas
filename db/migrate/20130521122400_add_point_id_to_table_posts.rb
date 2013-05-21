class AddPointIdToTablePosts < ActiveRecord::Migration
  def change
    add_column :posts, :point_id, :integer
  end
end
