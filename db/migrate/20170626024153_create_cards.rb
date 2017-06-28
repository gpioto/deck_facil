class CreateCards < ActiveRecord::Migration[5.1]
  def change
    create_table :cards do |t|
      t.string :wizards_card_code
      t.string :edition
      t.integer :quantity
      t.integer :deck_id, :limit => 8
    end
    add_foreign_key :cards, :decks, column: :deck_id, primary_key: :id
  end
end
