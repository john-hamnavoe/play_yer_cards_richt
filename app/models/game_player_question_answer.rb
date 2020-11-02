class GamePlayerQuestionAnswer < ApplicationRecord
  belongs_to :game_player
  belongs_to :question
end
