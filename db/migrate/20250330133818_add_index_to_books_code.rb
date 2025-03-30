class AddIndexToBooksCode < ActiveRecord::Migration[7.2]
  def change
    add_index :books, [:project_id, :code], unique: true
  end
end
