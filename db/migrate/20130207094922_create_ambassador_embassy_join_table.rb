class CreateAmbassadorEmbassyJoinTable < ActiveRecord::Migration
  def change
    create_table :ambassadors_embassies, id: false do |t|
      t.integer :ambassador_id
      t.integer :embassy_id
    end
  end
end
