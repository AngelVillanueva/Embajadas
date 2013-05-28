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

ActiveRecord::Schema.define(:version => 20130528080343) do

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

  add_index "ambassadors", ["created_at"], :name => "index_ambassadors_on_created_at"
  add_index "ambassadors", ["email"], :name => "index_ambassadors_on_email", :unique => true
  add_index "ambassadors", ["reset_password_token"], :name => "index_ambassadors_on_reset_password_token", :unique => true

  create_table "ambassadors_embassies", :id => false, :force => true do |t|
    t.integer "ambassador_id"
    t.integer "embassy_id"
  end

  add_index "ambassadors_embassies", ["ambassador_id", "embassy_id"], :name => "index_ambassadors_embassies_on_ambassador_id_and_embassy_id"
  add_index "ambassadors_embassies", ["embassy_id", "ambassador_id"], :name => "index_ambassadors_embassies_on_embassy_id_and_ambassador_id"

  create_table "assignments", :force => true do |t|
    t.string   "code"
    t.text     "tracking_url"
    t.string   "short_url"
    t.integer  "mission_id"
    t.integer  "ambassador_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "assignments", ["ambassador_id"], :name => "index_assignments_on_ambassador_id"
  add_index "assignments", ["mission_id"], :name => "index_assignments_on_mission_id"

  create_table "badges", :force => true do |t|
    t.integer  "ambassador_id"
    t.integer  "reward_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "badges", ["ambassador_id", "reward_id"], :name => "index_badges_on_ambassador_id_and_reward_id"
  add_index "badges", ["ambassador_id"], :name => "index_badges_on_ambassador_id"
  add_index "badges", ["created_at"], :name => "index_badges_on_created_at"
  add_index "badges", ["reward_id"], :name => "index_badges_on_reward_id"

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
  add_index "consuls", ["embassy_id"], :name => "index_consuls_on_embassy_id"
  add_index "consuls", ["reset_password_token"], :name => "index_consuls_on_reset_password_token", :unique => true

  create_table "embassies", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "mailing_codes", :force => true do |t|
    t.string   "tracking_code"
    t.integer  "embassy_id"
    t.datetime "expires_at"
    t.text     "landing_url"
    t.string   "short_url"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "mailing_codes", ["embassy_id"], :name => "index_mailing_codes_on_embassy_id"

  create_table "missions", :force => true do |t|
    t.string   "name"
    t.integer  "embassy_id"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.text     "short_description"
    t.string   "tracking_id"
    t.text     "tracking_url"
  end

  add_index "missions", ["embassy_id"], :name => "index_missions_on_embassy_id"

  create_table "points", :force => true do |t|
    t.integer  "mission_id"
    t.integer  "ambassador_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "points", ["ambassador_id"], :name => "index_points_on_ambassador_id"
  add_index "points", ["created_at"], :name => "index_points_on_created_at"
  add_index "points", ["mission_id"], :name => "index_points_on_mission_id"

  create_table "posts", :force => true do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "message"
    t.datetime "created_time"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.integer  "ambassador_id"
    t.integer  "slogan_id"
    t.integer  "point_id"
  end

  add_index "posts", ["ambassador_id"], :name => "index_posts_on_ambassador_id"
  add_index "posts", ["created_at"], :name => "index_posts_on_created_at"
  add_index "posts", ["point_id"], :name => "index_posts_on_point_id"
  add_index "posts", ["slogan_id"], :name => "index_posts_on_slogan_id"

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

  add_index "rewards", ["mission_id"], :name => "index_rewards_on_mission_id"

  create_table "search_terms", :force => true do |t|
    t.string   "term"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "consul_id"
  end

  add_index "search_terms", ["consul_id"], :name => "index_search_terms_on_consul_id"

  create_table "slogans", :force => true do |t|
    t.integer  "mission_id"
    t.integer  "search_term_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "slogans", ["mission_id"], :name => "index_slogans_on_mission_id"
  add_index "slogans", ["search_term_id"], :name => "index_slogans_on_search_term_id"

end
