class CreateSloganTable < ActiveRecord::Migration
  def change
    create_table :slogans do |t|
      t.string :term
      t.integer :embassy_id
    end
  end
end
