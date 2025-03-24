class AddUnitIdToRoles < ActiveRecord::Migration[7.2]
  def change
    add_column :roles, :unit_id, :integer
  end
end
