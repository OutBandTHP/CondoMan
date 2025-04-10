class AddRefinToProjects < ActiveRecord::Migration[7.2]
  def change
    add_column :projects, :refin, :string
  end
end
