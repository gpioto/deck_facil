class AddProfileNameToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :profile_name, :string
    add_column :users, :profile_last_name, :string
  end
end
