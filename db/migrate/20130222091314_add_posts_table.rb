class AddPostsTable < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :provider
      t.string :uid
      t.string :message
      t.datetime :created_time

      t.timestamps
    end
  end
end
