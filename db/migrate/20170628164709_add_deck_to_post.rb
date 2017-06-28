class AddDeckToPost < ActiveRecord::Migration[5.1]
  def change
    add_column :posts, :deck_id, :integer, :limit => 8
    add_foreign_key :posts, :decks, column: :deck_id, primary_key: :id
  end
end
