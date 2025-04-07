class CreateTransactions < ActiveRecord::Migration[7.2]
  def change
    create_table :transactions do |t|
      t.references :project,     null: false, foreign_key: true
      t.integer :finyear,        null: false
      t.datetime :trdate,        null: false
      t.boolean :trclosed
      t.references :trans_types, null: false, foreign_key: true
      t.references :book,        null: false, foreign_key: true
      t.references :supplier,    null: true, foreign_key: true
      t.references :unit,        null: true, foreign_key: true
      t.text :description,       null: false
      t.string :refin
      t.string :refex
      t.text :remarks
      t.decimal :sum,            null: false
      t.references :transactions, :link, null: true, foreign_key: {to_table: :transactions}

      t.timestamps
    end
    add_index :transactions, [:project_id, :finyear, :trdate, :id], unique: true
  end
end
