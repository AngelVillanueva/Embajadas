class AddCodesTable < ActiveRecord::Migration
  def change
    create_table :codes do |t|
      t.string :code
      t.integer :ambassador_id
      t.integer :mission_id

      t.timestamps
    end
  end
end
