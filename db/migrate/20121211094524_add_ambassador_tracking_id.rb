class AddAmbassadorTrackingId < ActiveRecord::Migration
  def change
    add_column :ambassadors, :tracking_id, :string
  end
end
