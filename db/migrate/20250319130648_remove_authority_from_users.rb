class RemoveAuthorityFromUsers < ActiveRecord::Migration[7.2]
  def change
    remove_column :users, :authority
  end
end
