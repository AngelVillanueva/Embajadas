class AddMinisterColumnToConsuls < ActiveRecord::Migration
  def change
    add_column :consuls, :minister, :boolean, default: false
  end
end
