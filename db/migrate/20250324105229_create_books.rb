class CreateBooks < ActiveRecord::Migration[7.2]
  def change
    create_table :books do |t|
      t.string :name
      t.string :kind
      t.references :project, foreign_key: true
      t.references :books, :group, null: true, foreign_key: {to_table: :books}

      t.timestamps
    end
  end
end
