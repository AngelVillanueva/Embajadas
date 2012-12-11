class AddTrackingIdToMissions < ActiveRecord::Migration
  def change
    add_column :missions, :tracking_id, :string
  end
end
