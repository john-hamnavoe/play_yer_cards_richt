class Episodes::HostLeaderboardEpisodesController < ApplicationController
  before_action :authenticate_user!
  before_action :allocate_points_and_set_game_state

  def show
    @game = Game.find_by(id: params[:id])
    @game_player_question_answers = GamePlayerQuestionAnswer.eager_load(
      game_player: :user
    ).where(
      game_question_id: @game.current_game_question_id
    ).order("COALESCE(points,0) + COALESCE(bonus_points, 0) DESC")
    @game_players = GamePlayer.where(game: @game).order(total_points: :desc)
  end

  private

  def allocate_points_and_set_game_state
    game = Game.find_by(id: params[:id])
    return if game.game_state == GameState::QUESTION_LEADERBOARD

    game.update(game_state: GameState::QUESTION_LEADERBOARD)
  end
end
