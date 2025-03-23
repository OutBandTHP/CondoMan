class CreateTransTypes < ActiveRecord::Migration[7.2]
  def change
    create_table :trans_types do |t|
      t.integer :code, null: false
      t.string  :name, null: false

      t.timestamps
    end
  end
end
