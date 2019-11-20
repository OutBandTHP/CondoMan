class CreateProjects < ActiveRecord::Migration[6.0]
  def change
    create_table :projects do |t|
      t.string :name
      t.string :admin, unique: true
      t.text :address
      t.string :email, unique: true

      t.timestamps
    end
  end
end
