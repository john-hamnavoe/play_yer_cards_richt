json.extract! game_player, :id, :game_id, :user_id, :total_points, :created_at, :updated_at
json.url game_player_url(game_player, format: :json)
