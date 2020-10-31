class CreateGameQuestions < ActiveRecord::Migration[6.0]
  def change
    create_table :game_questions do |t|
      t.references :game, null: false, foreign_key: true
      t.references :question, null: false, foreign_key: true
      t.references :user, null: true, foreign_key: true
      t.integer :current_card, default: 0
      t.string :current_cards, array: true, default: []
      t.string :card_deck, array: true, default: []
      t.boolean :last_guess_correct, default: nil

      t.timestamps
    end
  end
end
