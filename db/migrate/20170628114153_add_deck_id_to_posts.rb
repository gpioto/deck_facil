class AddDeckIdToPosts < ActiveRecord::Migration[5.1]
  def change
    add_column :posts, :deck_id, :integer
  end
end
