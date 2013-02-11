class DeleteMissionsSlogansTable < ActiveRecord::Migration
  def change
    drop_table :missions_slogans
    drop_table :slogans
  end
end
