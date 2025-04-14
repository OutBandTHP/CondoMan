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

ActiveRecord::Schema[7.2].define(version: 2025_04_08_111830) do
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

  create_table "ledgers", force: :cascade do |t|
    t.integer "project_id", null: false
    t.integer "finyear", null: false
    t.date "trdate", null: false
    t.integer "trans_type_id", null: false
    t.integer "transaction_id", null: false
    t.integer "book_id", null: false
    t.integer "supplier_id"
    t.integer "unit_id"
    t.text "description"
    t.string "refin"
    t.string "refex"
    t.text "remarks"
    t.decimal "debit"
    t.decimal "credit"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "\"project_id\", \"finyear\", \"trdate\", \"transaction\", \"id\"", name: "idx_on_project_id_finyear_trdate_transaction_id_2f7ef141ee", unique: true
    t.index ["book_id"], name: "index_ledgers_on_book_id"
    t.index ["project_id"], name: "index_ledgers_on_project_id"
    t.index ["supplier_id"], name: "index_ledgers_on_supplier_id"
    t.index ["trans_type_id"], name: "index_ledgers_on_trans_type_id"
    t.index ["transaction_id"], name: "index_ledgers_on_transaction_id"
    t.index ["unit_id"], name: "index_ledgers_on_unit_id"
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
    t.string "refin"
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

  create_table "suppliers", force: :cascade do |t|
    t.integer "project_id", null: false
    t.string "name"
    t.string "contact"
    t.string "email"
    t.string "phone"
    t.integer "book_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "\"project\", \"name\"", name: "index_suppliers_on_project_and_name"
    t.index ["book_id"], name: "index_suppliers_on_book_id"
    t.index ["project_id"], name: "index_suppliers_on_project_id"
  end

  create_table "trans_types", force: :cascade do |t|
    t.integer "code", null: false
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "transactions", force: :cascade do |t|
    t.integer "project_id", null: false
    t.integer "finyear", null: false
    t.datetime "trdate", null: false
    t.boolean "trclosed", default: false, null: false
    t.integer "trans_type_id", null: false
    t.integer "supplier_id"
    t.integer "unit_id"
    t.text "description", null: false
    t.string "refin", null: false
    t.string "refex"
    t.text "remarks"
    t.decimal "sum", null: false
    t.integer "transactions_id"
    t.integer "link_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["link_id"], name: "index_transactions_on_link_id"
    t.index ["project_id"], name: "index_transactions_on_project_id"
    t.index ["supplier_id"], name: "index_transactions_on_supplier_id"
    t.index ["trans_type_id"], name: "index_transactions_on_trans_type_id"
    t.index ["transactions_id"], name: "index_transactions_on_transactions_id"
    t.index ["unit_id"], name: "index_transactions_on_unit_id"
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
  add_foreign_key "ledgers", "books"
  add_foreign_key "ledgers", "projects"
  add_foreign_key "ledgers", "suppliers"
  add_foreign_key "ledgers", "trans_types"
  add_foreign_key "ledgers", "transactions"
  add_foreign_key "ledgers", "units"
  add_foreign_key "notifications", "projects"
  add_foreign_key "roles", "projects"
  add_foreign_key "roles", "users"
  add_foreign_key "suppliers", "books"
  add_foreign_key "suppliers", "projects"
  add_foreign_key "transactions", "projects"
  add_foreign_key "transactions", "suppliers"
  add_foreign_key "transactions", "trans_types"
  add_foreign_key "transactions", "transactions", column: "link_id"
  add_foreign_key "transactions", "transactions", column: "transactions_id"
  add_foreign_key "transactions", "units"
  add_foreign_key "units", "projects"
  add_foreign_key "years", "projects"
end
