class CreatePointsTable < ActiveRecord::Migration
  def change
    create_table :points do |t|
      t.integer :mission_id
      t.integer :ambassador_id

      t.timestamps
    end
  end
end
