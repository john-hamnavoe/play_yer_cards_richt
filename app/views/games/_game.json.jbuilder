json.extract! game, :id, :name, :user_id, :is_complete, :pin, :created_at, :updated_at
json.url game_url(game, format: :json)
