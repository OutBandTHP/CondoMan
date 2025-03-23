class AddAreaToUnits < ActiveRecord::Migration[7.2]
  def change
    add_column :units, :area, :decimal
  end
end
