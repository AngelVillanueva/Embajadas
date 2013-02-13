class AddConsulIdToSearchTerms < ActiveRecord::Migration
  def change
    add_column :search_terms, :consul_id, :integer
  end
end
