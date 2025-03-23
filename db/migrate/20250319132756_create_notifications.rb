class CreateNotifications < ActiveRecord::Migration[7.2]
  def change
    create_table :notifications do |t|
      t.text :text_message
      t.date :valid_from
      t.date :valid_to
      t.references :project, null: true, foreign_key: true

      t.timestamps
    end
  end
end
