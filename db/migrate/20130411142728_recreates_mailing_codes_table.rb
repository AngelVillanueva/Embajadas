class RecreatesMailingCodesTable < ActiveRecord::Migration
  def change
    create_table :mailing_codes do |t|
      t.string :tracking_code
      t.integer :embassy_id
      t.datetime :expires_at
      t.text :landing_url
      t.string :short_url

      t.timestamps
    end
  end
end
