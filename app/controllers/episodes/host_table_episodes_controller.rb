class Episodes::HostTableEpisodesController < ApplicationController
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
    return if game.game_state == GameState::QUESTION_TABLE

    game_question = game.current_game_question
    game_player = GamePlayer.find_by(game: game, user: game_question.user)

    if game_question.last_guess_correct
      game_player_question_answer = GamePlayerQuestionAnswer.find_by(game_question: game_question, game_player: game_player)
      game_player_question_answer.bonus_points = GamePoint::BONUS_FIVE if game_question.current_card == 5
      game_player_question_answer.bonus_points = GamePoint::BONUS_FOUR if game_question.current_card == 4
      game_player_question_answer.bonus_points = GamePoint::BONUS_THREE if game_question.current_card == 3
      game_player_question_answer.bonus_points = GamePoint::BONUS_TWO if game_question.current_card == 2
      game_player_question_answer.bonus_points = GamePoint::BONUS_ONE if game_question.current_card == 1

      game_player_question_answer.save
    else
      game_player_question_answer = GamePlayerQuestionAnswer.where(game_question: game_question).where.not(game_player: game_player)
      game_player_question_answer.each do |gpqa|
        gpqa.bonus_points = GamePoint::BONUS_OTHERS
        gpqa.save
      end
    end

    update_player_points(game, game_question)

    game.update(game_state: GameState::QUESTION_TABLE)
  end

  def update_player_points(game, game_question)
    game_players = GamePlayer.where(game: game)
    game_players.each do |gp|
      game_player_question_answer = GamePlayerQuestionAnswer.find_by(game_question: game_question, game_player: gp)
      gp.total_points = (gp.total_points || 0) + (game_player_question_answer.points || 0) + (game_player_question_answer.bonus_points || 0) if game_player_question_answer
      gp.save
    end
  end
end
