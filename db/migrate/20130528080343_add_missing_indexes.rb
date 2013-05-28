class AddMissingIndexes < ActiveRecord::Migration
  def change
    add_index :badges, :ambassador_id
    add_index :badges, :reward_id
    add_index :badges, [:ambassador_id, :reward_id]
    add_index :mailing_codes, :embassy_id
    add_index :ambassadors_embassies, [:embassy_id, :ambassador_id]
    add_index :ambassadors_embassies, [:ambassador_id, :embassy_id]
    add_index :search_terms, :consul_id
    add_index :missions, :embassy_id
    add_index :points, :ambassador_id
    add_index :points, :mission_id
    add_index :posts, :ambassador_id
    add_index :posts, :slogan_id
    add_index :posts, :point_id
    add_index :rewards, :mission_id
    add_index :slogans, :mission_id
    add_index :slogans, :search_term_id
    add_index :assignments, :ambassador_id
    add_index :assignments, :mission_id
    add_index :consuls, :embassy_id
  end
end
