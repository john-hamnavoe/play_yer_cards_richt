class AddGameStateToGame < ActiveRecord::Migration[6.0]
  def change
    add_column :games, :game_state, :integer, default: 0
  end
end
