class GamePoint < ApplicationRecord
  def readonly?
    true
  end

  QUESTION_FIRST = 50
  QUESTION_SECOND = 30
  QUESTION_THIRD = 20
  QUESTION_FOURTH = 10
  QUESTION_NO_SCORE = 0

  BONUS_FIVE = 50
  BONUS_FOUR = 30
  BONUS_THREE = 20
  BONUS_TWO = 10
  BONUS_ONE = 5

  BONUS_OTHERS = 10
end
