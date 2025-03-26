class CreateDeployBooks < ActiveRecord::Migration[7.2]
  def change
    create_table :deploy_books do |t|
      t.references :project, null: false, foreign_key: true
      t.references :trans_type, null: false, foreign_key: true
      t.references :book_neg, null: false, foreign_key: {to_table: :books}
      t.references :book_pos, null: false, foreign_key: {to_table: :books}

      t.timestamps
    end
  end
end
