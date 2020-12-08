class Episodes::PlayerBoardEpisodesController < ApplicationController
  before_action :authenticate_user!

  def show
    @game = Game.find_by(id: params[:id])
    @game_player = GamePlayer.find_by(game: @game, user: current_user)
    @game_current_answer = GamePlayerQuestionAnswer.find_by(game_player: @game_player, game_question_id: @game.current_game_question_id)
    @all_players = GamePlayer.where(game: @game).order(total_points: :desc)
  end

  def update
    game_player_id = params[:game_player_id]
    game_question_id = params[:game_question_id]
    answer = params[:answer]

    game_question_answer = GamePlayerQuestionAnswer.find_or_create_by(game_player_id: game_player_id, game_question_id: game_question_id)
    game_question_answer.answer = answer
    game_question_answer.save
  end
end
