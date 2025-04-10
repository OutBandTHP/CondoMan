class CreateLedgers < ActiveRecord::Migration[7.2]
  def change
    create_table :ledgers do |t|
      t.references :project,     null: false, foreign_key: true
      t.integer :finyear,        null: false
      t.date :trdate,            null: false
      t.references :trans_type,  null: false, foreign_key: true
      t.references :transaction, null: false, foreign_key: true
      t.references :book,        null: false, foreign_key: true
      t.references :supplier,    null: true, foreign_key: true
      t.references :unit,        null: true, foreign_key: true
      t.text :description
      t.string :refin
      t.string :refex
      t.text :remarks
      t.decimal :debit
      t.decimal :credit

      t.timestamps
    end
    add_index :ledgers, [:project_id, :finyear, :trdate, :transaction, :id], unique: true
  end
end
