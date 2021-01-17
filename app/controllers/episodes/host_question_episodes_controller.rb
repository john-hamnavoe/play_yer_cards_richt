class Episodes::HostQuestionEpisodesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_next_question

  def show
    @game = Game.find_by(id: params[:id])
    ActionCable.server.broadcast "game_channel", { content: @game.id }
  end

  private

  def set_next_question
    game = Game.find_by(id: params[:id])
    return if game.game_state == GameState::QUESTION_PLAY

    question = Question.where(is_public: game.use_public_questions).or(Question.where(user: current_user)).where.not(id: GameQuestion.pluck(:question_id)).sample
    game_question = GameQuestion.create(game: game, question: question)
    game.update(game_state: GameState::QUESTION_PLAY, current_game_question: game_question, question_number: game.question_number + 1)
  end
end
