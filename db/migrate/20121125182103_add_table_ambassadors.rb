class AddTableAmbassadors < ActiveRecord::Migration
  def change
    create_table :ambassadors do |t|
      t.string :name
      t.integer :embassy_id

      t.timestamps
    end
  end
end
