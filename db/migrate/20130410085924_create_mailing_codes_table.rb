class CreateMailingCodesTable < ActiveRecord::Migration
  def change
    create_table :mailing_codes do |t|
      t.string :tracking_code
      t.integer :embassy_id
      t.datetime :expires_at
    end
  end
end
