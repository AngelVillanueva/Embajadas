class AddAssignmentsTable < ActiveRecord::Migration
  def change
    create_table :assignments do |t|
      t.string :code
      t.text :tracking_url
      t.string :short_url
      t.integer :mission_id
      t.integer :ambassador_id

      t.timestamps
    end
  end
end
