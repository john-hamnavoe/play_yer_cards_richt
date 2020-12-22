class Episodes::HostAnswerEpisodesController < ApplicationController
  before_action :authenticate_user!
  before_action :allocate_points_and_set_game_state

  def show
    @game = Game.find_by(id: params[:id])
    answer = @game.current_game_question.question.answer

    @game_player_question_answers = GamePlayerQuestionAnswer.eager_load(
      game_player: :user
    ).where(
      game_question_id: @game.current_game_question_id
    ).order(Arel.sql("ABS(COALESCE(answer,0) - #{answer})"), created_at: :asc)
  end

  private

  def allocate_points_and_set_game_state
    game = Game.find_by(id: params[:id])
    return if game.game_state == GameState::QUESTION_ANSWER

    game_question = game.current_game_question

    game_player_question_answers = GamePlayerQuestionAnswer.where(
      game_question_id: game.current_game_question_id
    ).order(Arel.sql("ABS(COALESCE(answer,0) - #{game_question.question.answer})"), created_at: :asc)

    game_question.user_id = game_player_question_answers[0].game_player.user_id
    game_question.save

    game_player_question_answers.each_with_index do |gpqa, i|
      gpqa.points = GamePoint::QUESTION_FIRST if i.zero?
      gpqa.points = GamePoint::QUESTION_SECOND if i == 1
      gpqa.points = GamePoint::QUESTION_THIRD if i == 2
      gpqa.points = GamePoint::QUESTION_FOURTH if i == 3
      gpqa.points = GamePoint::QUESTION_NO_SCORE if i >= 4

      gpqa.points += GamePoint::QUESTION_EXACT_MATCH if gpqa.answer == game_question.question.answer

      gpqa.save
    end

    game.update(game_state: GameState::QUESTION_ANSWER)
  end
end
