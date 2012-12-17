class AddTrackingUrlToMissions < ActiveRecord::Migration
  def change
    add_column :missions, :tracking_url, :string
  end
end
