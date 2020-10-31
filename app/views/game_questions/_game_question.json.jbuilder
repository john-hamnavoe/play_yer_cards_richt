json.extract! game_question, :id, :game_id, :question_id, :current_card, :card_deck, :created_at, :updated_at
json.url game_question_url(game_question, format: :json)
