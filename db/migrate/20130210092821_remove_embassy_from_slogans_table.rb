class RemoveEmbassyFromSlogansTable < ActiveRecord::Migration
  def change
    remove_column :slogans, :embassy_id
  end
end
