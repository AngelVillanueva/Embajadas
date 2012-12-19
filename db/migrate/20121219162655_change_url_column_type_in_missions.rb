class ChangeUrlColumnTypeInMissions < ActiveRecord::Migration
  def up
    change_column :missions, :tracking_url, :text
  end

  def down
    change_column :missions, :tracking_url, :string
  end
end
