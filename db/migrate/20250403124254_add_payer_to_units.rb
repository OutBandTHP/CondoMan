class AddPayerToUnits < ActiveRecord::Migration[7.2]
  def change
    add_column :units, :payer, :string
  end
end
