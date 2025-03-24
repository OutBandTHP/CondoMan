class RemoveUnitFromRoles < ActiveRecord::Migration[7.2]
  def change
    remove_column :roles, :unit
  end
end
