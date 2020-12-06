class Episodes::HostAnswerEpisodesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_game_state

  def show
    @game = Game.find_by(id: params[:id])
    @game_player_question_answers = GamePlayerQuestionAnswer.eager_load(game_player: :user).where(game_question_id: @game.current_game_question_id).order(:updated_at)
  end

  private

  def set_game_state
    game = Game.find_by(id: params[:id])
    return if game.game_state == GameState::QUESTION_ANSWER

    game.update(game_state: GameState::QUESTION_ANSWER)
  end
end
