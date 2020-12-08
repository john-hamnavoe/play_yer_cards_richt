class Episodes::FinishedEpisodesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_finish_state

  def show
    @game = Game.find_by(id: params[:id])
    @game_players = GamePlayer.where(game: @game).order(total_points: :desc)
    ActionCable.server.broadcast "game_channel", content: @game.id
  end

  private

  def set_finish_state
    game = Game.find_by(id: params[:id])
    return if game.game_state == GameState::FINISHED

    game.game_state = GameState::FINISHED
    game.is_complete = true
    game.save
  end
end
