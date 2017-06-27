# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170626024153) do

  create_table "cards", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string "wizards_card_code"
    t.string "edition"
    t.integer "quantity"
    t.bigint "deck_id"
    t.index ["deck_id"], name: "fk_rails_6c4effce17"
  end

  create_table "decks", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string "name"
    t.string "format"
    t.string "description"
    t.string "photo"
    t.integer "user_id"
    t.index ["user_id"], name: "fk_rails_5d31349cbe"
  end

  create_table "users", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string "name"
    t.string "email"
    t.string "password"
    t.string "salt"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "confirmed_email", default: false
    t.string "confirm_token"
    t.string "password_reset_token"
    t.datetime "password_reset_sent_at"
    t.string "profile_name"
    t.string "profile_last_name"
    t.string "profile_image"
    t.integer "logins"
  end

  add_foreign_key "cards", "decks"
  add_foreign_key "decks", "users"
end
