class Episodes::HostTableEpisodesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_game_state

  def show
    @game = Game.find_by(id: params[:id])
  end

  private

  def set_game_state
    game = Game.find_by(id: params[:id])
    return if game.game_state == GameState::QUESTION_TABLE

    game.update(game_state: GameState::QUESTION_TABLE)
  end
end
