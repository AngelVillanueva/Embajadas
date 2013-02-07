class RemoveEmbassyIdFromAmbassadors < ActiveRecord::Migration
  def up
    remove_column :ambassadors, :embassy_id
  end

  def down
    add_column :ambassadors, :embassy_id, :integer
  end
end
