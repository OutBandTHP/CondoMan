class AddCodeToBooks < ActiveRecord::Migration[7.2]
  def change
    add_column :books, :code, :integer
  end
end
