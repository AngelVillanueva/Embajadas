class AddConsulsToDb < ActiveRecord::Migration
  def change
    create_table :consuls do |t|
      t.string :name
      t.integer :embassy_id

      t.timestamps
    end
  end
end
