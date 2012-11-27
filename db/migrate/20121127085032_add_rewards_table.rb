class AddRewardsTable < ActiveRecord::Migration
  def change
    create_table :rewards do |t|
      t.string :name
      t.integer :mission_id

      t.timestamps
    end
  end
end
