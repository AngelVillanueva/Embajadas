class AddAmbassadorIdFieldToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :ambassador_id, :integer
  end
end
