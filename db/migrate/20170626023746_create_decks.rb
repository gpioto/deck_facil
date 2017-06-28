class CreateDecks < ActiveRecord::Migration[5.1]
  def change
    create_table :decks do |t|
      t.string :name
      t.string :format
      t.string :description
      t.string :photo
      t.integer :user_id
    end
    add_foreign_key :decks, :users, column: :user_id, primary_key: :id
  end
end
