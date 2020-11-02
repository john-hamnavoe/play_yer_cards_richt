class CreateGamePlayerQuestionAnswers < ActiveRecord::Migration[6.0]
  def change
    create_table :game_player_question_answers do |t|
      t.references :game_player, null: false, foreign_key: true
      t.references :question, null: false, foreign_key: true
      t.float :answer
      t.integer :points
      t.integer :bonus_points

      t.timestamps
    end
  end
end
