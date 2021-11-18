class CreateRoles < ActiveRecord::Migration[6.0]
  def change
    create_table :roles do |t|
      t.integer :authority
      t.date :since
      t.references :user, null: false, foreign_key: true
      t.references :project, foreign_key: true
      t.integer :unit

      t.timestamps
    end
  end
end
