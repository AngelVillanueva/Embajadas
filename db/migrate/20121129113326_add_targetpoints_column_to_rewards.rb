class AddTargetpointsColumnToRewards < ActiveRecord::Migration
  def change
    add_column :rewards, :target_points, :integer
  end
end
