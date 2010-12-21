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

ActiveRecord::Schema.define(:version => 20101221201721) do

  create_table "pages", :force => true do |t|
    t.string   "name"
    t.string   "image"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
    t.string   "name_url"
    t.integer  "page_order"
  end

  add_index "pages", ["name"], :name => "index_pages_on_name", :unique => true
  add_index "pages", ["name_url"], :name => "index_pages_on_name_url", :unique => true
  add_index "pages", ["page_order"], :name => "index_pages_on_page_order"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "permissions"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "encrypted_password"
    t.string   "salt"
  end

  add_index "users", ["name"], :name => "index_users_on_name", :unique => true

end
