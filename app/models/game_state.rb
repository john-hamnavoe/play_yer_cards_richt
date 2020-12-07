class GameState < ApplicationRecord
  def readonly?
    true
  end

  CREATED = 0
  QUESTION_PLAY = 1
  QUESTION_ANSWER = 2
  QUESTION_BONUS = 3
  QUESTION_TABLE = 4
  FINISHED = 5
end
