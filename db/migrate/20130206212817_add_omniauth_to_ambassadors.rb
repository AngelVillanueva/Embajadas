class AddOmniauthToAmbassadors < ActiveRecord::Migration
  def change
    add_column :ambassadors, :provider, :string
    add_column :ambassadors, :uid, :string
  end
end
