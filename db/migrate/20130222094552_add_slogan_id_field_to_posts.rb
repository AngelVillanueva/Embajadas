class AddSloganIdFieldToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :slogan_id, :integer
  end
end
