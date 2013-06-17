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

ActiveRecord::Schema.define(:version => 20130617145004) do

  create_table "active_admin_comments", :force => true do |t|
    t.string   "resource_id",   :null => false
    t.string   "resource_type", :null => false
    t.integer  "author_id"
    t.string   "author_type"
    t.text     "body"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "namespace"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], :name => "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], :name => "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], :name => "index_admin_notes_on_resource_type_and_resource_id"

  create_table "admin_users", :force => true do |t|
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
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "admin_users", ["email"], :name => "index_admin_users_on_email", :unique => true
  add_index "admin_users", ["reset_password_token"], :name => "index_admin_users_on_reset_password_token", :unique => true

  create_table "gas", :force => true do |t|
    t.integer "product_id"
    t.integer "date"
    t.integer "qty"
  end

  add_index "gas", ["date"], :name => "index_gas_on_date_update"
  add_index "gas", ["product_id"], :name => "index_gas_on_product_id"
  add_index "gas", ["qty"], :name => "index_gas_on_qty"

  create_table "gas_catalog_standards", :force => true do |t|
    t.string  "item_id"
    t.string  "manufacturer_item_id"
    t.string  "upc_or_ean_id"
    t.string  "manufacturer"
    t.string  "product_name"
    t.string  "short_description"
    t.string  "extended_description"
    t.string  "images"
    t.float   "weight"
    t.float   "length"
    t.float   "width"
    t.float   "height"
    t.integer "categories"
    t.string  "retail_map"
    t.string  "msrp"
    t.string  "stock_status"
  end

  create_table "gas_cost_standards", :force => true do |t|
    t.string   "item_id"
    t.float    "cost"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "retail_map"
    t.string   "msrp"
  end

  create_table "gas_inventory_standards", :force => true do |t|
    t.string  "item_id"
    t.integer "qty_available"
    t.string  "stock_status"
    t.string  "active_status"
  end

  create_table "itemids", :force => true do |t|
    t.string "itemid"
  end

  add_index "itemids", ["itemid"], :name => "index_itemids_on_itemid"

  create_table "items", :force => true do |t|
    t.string "itemid"
  end

  add_index "items", ["id"], :name => "index_items_on_id"
  add_index "items", ["itemid"], :name => "index_items_on_item"

  create_table "manufacturers", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "notification_modes", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "notifications", :force => true do |t|
    t.boolean  "treshhold_notification"
    t.integer  "treshhold"
    t.boolean  "start_qty_notification"
    t.integer  "start_qty"
    t.string   "emails"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
    t.integer  "notification_mode_id"
  end

  create_table "products", :force => true do |t|
    t.string   "item_id"
    t.string   "manufacturer_item_id"
    t.string   "upc_or_ean_id"
    t.integer  "manufacturer_id"
    t.string   "product_name"
    t.string   "short_description"
    t.string   "extended_description"
    t.string   "images"
    t.float    "weight"
    t.float    "length"
    t.float    "width"
    t.float    "height"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
    t.float    "cost"
    t.integer  "source_id"
  end

  add_index "products", ["item_id"], :name => "index_products_on_item_id"
  add_index "products", ["manufacturer_id"], :name => "index_products_on_manufacturer_id"
  add_index "products", ["upc_or_ean_id"], :name => "index_products_on_upc_or_ean_id"

  create_table "quantities", :force => true do |t|
    t.integer "item_id"
    t.integer "qty"
    t.integer "date"
  end

  add_index "quantities", ["date"], :name => "index_quantities_on_date"
  add_index "quantities", ["item_id"], :name => "index_quantities_on_item_id"
  add_index "quantities", ["qty"], :name => "index_quantities_on_qty"

  create_table "rsr", :force => true do |t|
    t.integer "product_id"
    t.integer "date"
    t.integer "qty"
  end

  add_index "rsr", ["date"], :name => "index_rsr_on_date"
  add_index "rsr", ["product_id"], :name => "index_rsr_on_product_id"
  add_index "rsr", ["qty"], :name => "index_rsr_on_qty"

  create_table "rsr_inventories", :force => true do |t|
    t.string   "RSRStockNumber"
    t.string   "UPCCode"
    t.string   "ProductDescription"
    t.integer  "DepartmentNumber"
    t.string   "ManufacturerId"
    t.float    "RetailPrice"
    t.float    "RSRRegularPrice"
    t.float    "ProductWeight"
    t.integer  "InventoryQuantity"
    t.string   "Model"
    t.string   "FullManufacturerName"
    t.string   "ManufacturerPartNumber"
    t.string   "AllocatedCloseoutDeleted"
    t.text     "ExpandedProductDescription"
    t.text     "Imagename"
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
  end

  create_table "sources", :force => true do |t|
    t.string   "name"
    t.string   "db_name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "static_pages", :force => true do |t|
    t.string   "name"
    t.string   "titile"
    t.text     "content"
    t.string   "slug"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
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
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
