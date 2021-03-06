# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_01_16_173538) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "game_player_question_answers", force: :cascade do |t|
    t.bigint "game_player_id", null: false
    t.bigint "game_question_id", null: false
    t.float "answer"
    t.integer "points"
    t.integer "bonus_points"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["game_player_id"], name: "index_game_player_question_answers_on_game_player_id"
    t.index ["game_question_id"], name: "index_game_player_question_answers_on_game_question_id"
  end

  create_table "game_players", force: :cascade do |t|
    t.bigint "game_id", null: false
    t.bigint "user_id", null: false
    t.integer "total_points"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["game_id"], name: "index_game_players_on_game_id"
    t.index ["user_id"], name: "index_game_players_on_user_id"
  end

  create_table "game_questions", force: :cascade do |t|
    t.bigint "game_id", null: false
    t.bigint "question_id", null: false
    t.bigint "user_id"
    t.integer "current_card", default: 0
    t.string "current_cards", default: [], array: true
    t.string "card_deck", default: [], array: true
    t.boolean "last_guess_correct"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["game_id"], name: "index_game_questions_on_game_id"
    t.index ["question_id"], name: "index_game_questions_on_question_id"
    t.index ["user_id"], name: "index_game_questions_on_user_id"
  end

  create_table "games", force: :cascade do |t|
    t.string "name"
    t.bigint "user_id", null: false
    t.boolean "is_complete", default: false, null: false
    t.integer "pin"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "game_state", default: 0
    t.bigint "current_game_question_id"
    t.integer "number_of_questions", default: 30
    t.integer "question_number", default: 0
    t.boolean "use_public_questions", default: true
    t.index ["current_game_question_id"], name: "index_games_on_current_game_question_id"
    t.index ["user_id"], name: "index_games_on_user_id"
  end

  create_table "questions", force: :cascade do |t|
    t.string "question"
    t.float "answer"
    t.boolean "is_public", default: true
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_questions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "team_name"
    t.boolean "is_admin", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "game_player_question_answers", "game_players"
  add_foreign_key "game_player_question_answers", "game_questions"
  add_foreign_key "game_players", "games"
  add_foreign_key "game_players", "users"
  add_foreign_key "game_questions", "games"
  add_foreign_key "game_questions", "questions"
  add_foreign_key "game_questions", "users"
  add_foreign_key "games", "game_questions", column: "current_game_question_id"
  add_foreign_key "games", "users"
  add_foreign_key "questions", "users"
end
