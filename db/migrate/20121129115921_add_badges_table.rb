class AddBadgesTable < ActiveRecord::Migration
  def change
    create_table :badges do |t|
      t.integer :ambassador_id
      t.integer :reward_id

      t.timestamps
    end
  end
end
