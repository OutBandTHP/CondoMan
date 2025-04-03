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

ActiveRecord::Schema[7.2].define(version: 2025_04_03_124254) do
  create_table "books", force: :cascade do |t|
    t.string "name"
    t.string "kind"
    t.integer "project_id"
    t.integer "books_id"
    t.integer "group_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "code"
    t.index ["books_id"], name: "index_books_on_books_id"
    t.index ["group_id"], name: "index_books_on_group_id"
    t.index ["project_id", "code"], name: "index_books_on_project_id_and_code", unique: true
    t.index ["project_id"], name: "index_books_on_project_id"
  end

  create_table "buildings", force: :cascade do |t|
    t.text "address"
    t.string "id_code"
    t.integer "project_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_buildings_on_project_id"
  end

  create_table "deploy_books", force: :cascade do |t|
    t.integer "project_id", null: false
    t.integer "trans_type_id", null: false
    t.integer "book_neg_id", null: false
    t.integer "book_pos_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["book_neg_id"], name: "index_deploy_books_on_book_neg_id"
    t.index ["book_pos_id"], name: "index_deploy_books_on_book_pos_id"
    t.index ["project_id"], name: "index_deploy_books_on_project_id"
    t.index ["trans_type_id"], name: "index_deploy_books_on_trans_type_id"
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
    t.date "current_month"
    t.decimal "total_area"
    t.integer "gl_tenants"
    t.integer "gl_suppliers"
    t.integer "gl_expenses"
    t.integer "gl_income"
    t.integer "gl_budget"
    t.string "tx_monthly"
    t.string "tx_expense"
    t.string "tx_income"
    t.string "tx_support"
    t.string "gr_cash_flow"
    t.string "gr_pos_side"
    t.string "gr_neg_side"
    t.string "gr_open_balance"
    t.string "gr_for_balance"
    t.string "gr_for_flow"
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
    t.string "payer"
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

  create_table "years", force: :cascade do |t|
    t.integer "project_id", null: false
    t.integer "finyear"
    t.decimal "ppm"
    t.boolean "closed", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_years_on_project_id"
  end

  add_foreign_key "books", "books", column: "books_id"
  add_foreign_key "books", "books", column: "group_id"
  add_foreign_key "books", "projects"
  add_foreign_key "buildings", "projects"
  add_foreign_key "deploy_books", "books", column: "book_neg_id"
  add_foreign_key "deploy_books", "books", column: "book_pos_id"
  add_foreign_key "deploy_books", "projects"
  add_foreign_key "deploy_books", "trans_types"
  add_foreign_key "notifications", "projects"
  add_foreign_key "roles", "projects"
  add_foreign_key "roles", "users"
  add_foreign_key "units", "projects"
  add_foreign_key "years", "projects"
end
