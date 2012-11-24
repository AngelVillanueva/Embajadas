class CreateTableEmbassies < ActiveRecord::Migration
  def change
    create_table :embassies do |t|
      t.string :name

      t.timestamps
    end
  end
end
