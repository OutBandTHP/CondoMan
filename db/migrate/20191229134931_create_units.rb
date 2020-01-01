class CreateUnits < ActiveRecord::Migration[6.0]
  def change
    create_table :units do |t|
      t.integer :number
      t.integer :building
      t.integer :floor
      t.references :project, null: false, foreign_key: true
      t.date :since

      t.timestamps
    end
  end
end
