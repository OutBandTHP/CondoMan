class AddColumnToProjects < ActiveRecord::Migration[6.0]
  def change
    add_column :projects, :since, :date
  end
end
