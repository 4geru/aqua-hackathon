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

ActiveRecord::Schema.define(version: 2018_04_22_022337) do

  create_table "admins", force: :cascade do |t|
    t.string "nickname"
    t.string "email", null: false
    t.string "password_digest", null: false
    t.string "password_salt", null: false
    t.string "reset_password_key"
    t.datetime "reset_password_key_expired_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_key"], name: "index_admins_on_reset_password_key", unique: true
  end

  create_table "shops", force: :cascade do |t|
    t.string "shop_name", null: false
    t.string "shop_kana_name", null: false
    t.string "post_num", null: false
    t.string "prefecture", null: false
    t.string "address", null: false
    t.string "address_kana", null: false
    t.string "business_hour"
    t.string "tel_num"
    t.string "fax_num"
    t.string "hp_link"
    t.string "maintenance_man"
    t.string "maintenance_tel_num"
    t.string "business"
    t.string "business_tel_num"
    t.integer "owner_id"
    t.string "owner_name"
    t.integer "fc_id"
    t.string "fc_company_name"
    t.string "shop_open_date"
    t.string "position"
    t.float "longitude"
    t.float "parallel"
    t.integer "group_id"
    t.string "group_name"
    t.binary "shop_outer"
    t.binary "shop_inner"
    t.binary "shop_outer_s"
    t.binary "shop_inner_s"
  end

  create_table "user_machines", force: :cascade do |t|
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "shop_id", default: 0, null: false
    t.integer "machine_num", default: 0, null: false
    t.string "machine_short_name"
    t.string "manufacture"
    t.string "drum"
    t.string "part_num"
    t.string "machine_name"
    t.string "capacity"
    t.string "process"
    t.string "payment"
    t.float "interest"
    t.binary "machine_image"
    t.integer "price"
    t.integer "management_free"
    t.integer "anual_sales"
    t.index ["user_id"], name: "index_user_machines_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "nickname"
    t.string "email", null: false
    t.string "password_digest", null: false
    t.string "password_salt", null: false
    t.string "reset_password_key"
    t.datetime "reset_password_key_expired_at"
    t.datetime "confirmed_at"
    t.string "confirmation_key"
    t.datetime "confirmation_key_expired_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "owner_id"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

end
