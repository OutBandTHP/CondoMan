class CreateBuildings < ActiveRecord::Migration[6.0]
  def change
    create_table :buildings do |t|
      t.text :address
      t.string :id_code
      t.references :project, null: false, foreign_key: true

      t.timestamps
    end
  end
end
