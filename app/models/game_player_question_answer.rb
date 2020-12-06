class GamePlayerQuestionAnswer < ApplicationRecord
  belongs_to :game_player
  belongs_to :game_question
end
