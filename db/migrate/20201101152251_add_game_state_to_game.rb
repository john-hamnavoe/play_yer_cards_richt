class AddGameStateToGame < ActiveRecord::Migration[6.0]
  def change
    add_column :games, :game_state, :integer, default: 0
    add_reference :games, :current_game_question, null: true, foreign_key: { to_table: :game_questions }
  end
end
