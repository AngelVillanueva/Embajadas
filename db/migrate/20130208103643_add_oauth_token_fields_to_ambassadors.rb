class AddOauthTokenFieldsToAmbassadors < ActiveRecord::Migration
  def change
    add_column :ambassadors, :oauth_token, :string
    add_column :ambassadors, :oauth_expires_at, :datetime
  end
end
