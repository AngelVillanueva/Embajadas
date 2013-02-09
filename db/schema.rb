# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130208103643) do

  create_table "ambassadors", :force => true do |t|
    t.string   "name"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "tracking_id"
    t.string   "provider"
    t.string   "uid"
    t.string   "oauth_token"
    t.datetime "oauth_expires_at"
  end

  add_index "ambassadors", ["email"], :name => "index_ambassadors_on_email", :unique => true
  add_index "ambassadors", ["reset_password_token"], :name => "index_ambassadors_on_reset_password_token", :unique => true

  create_table "ambassadors_embassies", :id => false, :force => true do |t|
    t.integer "ambassador_id"
    t.integer "embassy_id"
  end

  create_table "assignments", :force => true do |t|
    t.string   "code"
    t.text     "tracking_url"
    t.string   "short_url"
    t.integer  "mission_id"
    t.integer  "ambassador_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "badges", :force => true do |t|
    t.integer  "ambassador_id"
    t.integer  "reward_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "consuls", :force => true do |t|
    t.string   "name"
    t.integer  "embassy_id"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.string   "email",                  :default => "",    :null => false
    t.string   "encrypted_password",     :default => "",    :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.boolean  "minister",               :default => false
  end

  add_index "consuls", ["email"], :name => "index_consuls_on_email", :unique => true
  add_index "consuls", ["reset_password_token"], :name => "index_consuls_on_reset_password_token", :unique => true

  create_table "embassies", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "missions", :force => true do |t|
    t.string   "name"
    t.integer  "embassy_id"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.text     "short_description"
    t.string   "tracking_id"
    t.text     "tracking_url"
  end

  create_table "points", :force => true do |t|
    t.integer  "mission_id"
    t.integer  "ambassador_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "rails_admin_histories", :force => true do |t|
    t.text     "message"
    t.string   "username"
    t.integer  "item"
    t.string   "table"
    t.integer  "month",      :limit => 2
    t.integer  "year",       :limit => 8
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
  end

  add_index "rails_admin_histories", ["item", "table", "month", "year"], :name => "index_rails_admin_histories"

  create_table "rewards", :force => true do |t|
    t.string   "name"
    t.integer  "mission_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.integer  "target_points"
  end

end
