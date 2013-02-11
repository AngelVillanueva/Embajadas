class CreateMissionsSlogansTable < ActiveRecord::Migration
  def change
    create_table :missions_slogans, id: false do |t|
      t.integer :mission_id
      t.integer :slogan_id
    end
  end
end
