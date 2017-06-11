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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170611094004) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"
  enable_extension "citext"

  create_table "attribute_values", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.uuid   "attribute_id"
    t.string "label"
  end

  add_index "attribute_values", ["attribute_id"], name: "index_attribute_values_on_attribute_id", using: :btree

  create_table "attributes", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.string  "code"
    t.string  "label"
    t.integer "value_type"
  end

  create_table "categories", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.string "title"
    t.string "ancestry"
  end

  add_index "categories", ["ancestry"], name: "index_categories_on_ancestry", using: :btree

  create_table "friendly_id_slugs", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "product_attributes", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.uuid   "product_id"
    t.uuid   "attribute_id"
    t.string "value"
  end

  add_index "product_attributes", ["attribute_id"], name: "index_product_attributes_on_attribute_id", using: :btree
  add_index "product_attributes", ["product_id"], name: "index_product_attributes_on_product_id", using: :btree

  create_table "product_categories", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.uuid "product_id"
    t.uuid "category_id"
  end

  add_index "product_categories", ["category_id"], name: "index_product_categories_on_category_id", using: :btree
  add_index "product_categories", ["product_id"], name: "index_product_categories_on_product_id", using: :btree

  create_table "products", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.string "title"
    t.string "avatar_image_id"
    t.string "avatar_image_filename"
    t.string "avatar_image_content_type"
    t.string "slug"
  end

  add_index "products", ["slug"], name: "index_products_on_slug", unique: true, using: :btree

  create_table "report_products", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.uuid    "report_id"
    t.uuid    "product_id"
    t.decimal "unit_value", precision: 8, scale: 2
    t.decimal "quantity",   precision: 8, scale: 2
  end

  add_index "report_products", ["product_id"], name: "index_report_products_on_product_id", using: :btree
  add_index "report_products", ["report_id"], name: "index_report_products_on_report_id", using: :btree

  create_table "reports", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.uuid     "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "reports", ["user_id"], name: "index_reports_on_user_id", using: :btree

  create_table "users", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.citext   "email"
    t.string   "encrypted_password"
    t.integer  "role"
    t.string   "avatar_image_id"
    t.string   "avatar_image_filename"
    t.string   "avatar_image_content_type"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_foreign_key "attribute_values", "attributes"
  add_foreign_key "product_attributes", "attributes"
  add_foreign_key "product_attributes", "products"
  add_foreign_key "product_categories", "categories"
  add_foreign_key "product_categories", "products"
  add_foreign_key "report_products", "products"
  add_foreign_key "report_products", "reports"
  add_foreign_key "reports", "users"
end
