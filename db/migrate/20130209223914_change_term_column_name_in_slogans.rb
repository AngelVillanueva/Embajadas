class ChangeTermColumnNameInSlogans < ActiveRecord::Migration
  def change
    rename_column :slogans, :term, :search_term
  end
end
