class DropMailingCodeTable < ActiveRecord::Migration
  def change
    drop_table :mailing_codes
  end
end
