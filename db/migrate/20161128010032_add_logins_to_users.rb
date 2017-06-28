class AddLoginsToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :logins, :integer
  end
end
