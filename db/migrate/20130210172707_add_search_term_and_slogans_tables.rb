class AddSearchTermAndSlogansTables < ActiveRecord::Migration
  def change
    create_table :search_terms do |t|
      t.string :term
      
      t.timestamps
    end
    create_table :slogans do |t|
      t.integer :mission_id
      t.integer :search_term_id
      
      t.timestamps
    end
  end
end
