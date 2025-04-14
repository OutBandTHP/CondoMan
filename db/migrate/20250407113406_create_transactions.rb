class CreateTransactions < ActiveRecord::Migration[7.2]
  def change
    create_table :transactions do |t|
      t.references :project,     null: false, foreign_key: true
      t.integer :finyear,        null: false
      t.datetime :trdate,        null: false
      t.boolean :trclosed,       null: false, default: false
      t.references :trans_type,  null: false, foreign_key: true
      t.references :supplier,    null: true, foreign_key: true
      t.references :unit,        null: true, foreign_key: true
      t.text :description,       null: false
      t.string :refin,           null: false
      t.string :refex
      t.text :remarks
      t.decimal :sum,            null: false
      t.references :transactions, :link, null: true, foreign_key: {to_table: :transactions}

      t.timestamps
    end
  end
end
