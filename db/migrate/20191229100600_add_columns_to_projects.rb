class AddColumnsToProjects < ActiveRecord::Migration[6.0]
  def change
    add_column :projects, :no_buildings, :integer
    add_column :projects, :no_units, :integer
  end
end
