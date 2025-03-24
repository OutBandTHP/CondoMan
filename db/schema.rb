# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.2].define(version: 2025_03_24_102728) do
  create_table "buildings", force: :cascade do |t|
    t.text "address"
    t.string "id_code"
    t.integer "project_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_buildings_on_project_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.text "text_message"
    t.date "valid_from"
    t.date "valid_to"
    t.integer "project_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_notifications_on_project_id"
  end

  create_table "projects", force: :cascade do |t|
    t.string "name"
    t.string "admin"
    t.text "address"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "since"
    t.integer "no_buildings"
    t.integer "no_units"
  end

  create_table "roles", force: :cascade do |t|
    t.integer "authority"
    t.date "since"
    t.integer "user_id", null: false
    t.integer "project_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "unit_id"
    t.index ["project_id"], name: "index_roles_on_project_id"
    t.index ["user_id"], name: "index_roles_on_user_id"
  end

  create_table "trans_types", force: :cascade do |t|
    t.integer "code", null: false
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "units", force: :cascade do |t|
    t.integer "number"
    t.integer "building"
    t.integer "floor"
    t.integer "project_id", null: false
    t.date "since"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "area"
    t.index ["project_id"], name: "index_units_on_project_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.string "remember_digest"
    t.string "activation_digest"
    t.boolean "activated"
    t.datetime "activated_at", precision: nil
    t.string "reset_digest"
    t.datetime "reset_sent_at", precision: nil
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "buildings", "projects"
  add_foreign_key "notifications", "projects"
  add_foreign_key "roles", "projects"
  add_foreign_key "roles", "users"
  add_foreign_key "units", "projects"
end
