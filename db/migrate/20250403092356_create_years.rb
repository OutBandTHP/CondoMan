class CreateYears < ActiveRecord::Migration[7.2]
  def change
    create_table :years do |t|
      t.references :project, null: false, foreign_key: true
      t.integer :finyear
      t.decimal :ppm
      t.boolean :closed,     default: false

      t.timestamps
    end
  end
end
