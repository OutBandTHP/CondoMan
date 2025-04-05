class CreateSuppliers < ActiveRecord::Migration[7.2]
  def change
    create_table :suppliers do |t|
      t.references :project, null: false, foreign_key: true
      t.string :name
      t.string :contact
      t.string :email
      t.string :phone
      t.references :book, null: true, foreign_key: true

      t.timestamps
    end
    add_index :suppliers, [:project, :name]
  end
end
