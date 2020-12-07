class Episodes::HostBonusEpisodesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_game_state

  def show
    @game = Game.find_by(id: params[:id])
    @cards = @game.current_game_question.current_cards
    @shown_cards = @game.current_game_question.current_card
    @last_guess_correct = @game.current_game_question.last_guess_correct
  end

  def higher
    @game = Game.find_by(id: params[:id])
    @question = @game.current_game_question
    @question.last_guess_correct = next_card_is_higher
    update_question_state
  end

  def lower
    @game = Game.find_by(id: params[:id])
    @question = @game.current_game_question
    @question.last_guess_correct = next_card_is_lower
    update_question_state
  end

  private

  def update_question_state
    next_card = (@question.current_card + 1)
    if !@question.last_guess_correct && next_card < 5
      @question.user_id = next_user
    end
    @question.current_card = next_card

    @question.save
    redirect_to episodes_host_bonus_episode_path(@game.id)
  end

  def set_game_state
    game = Game.find_by(id: params[:id])
    return if game.game_state == GameState::QUESTION_BONUS

    game.update(game_state: GameState::QUESTION_BONUS)
  end

  def next_card_is_higher
    current_card_rank, next_card_rank = ranks
    next_card_rank > current_card_rank
  end

  def next_card_is_lower
    current_card_rank, next_card_rank = ranks
    next_card_rank < current_card_rank
  end

  def ranks
    current_card = @question.current_cards[@question.current_card]
    next_card = @question.current_cards[@question.current_card + 1]
    current_card_rank = card_order.index(current_card[0])
    next_card_rank = card_order.index(next_card[0])
    if current_card_rank == next_card_rank
      current_card_rank = suit_order.index(current_card[1])
      next_card_rank =  suit_order.index(next_card[1])
    end

    return current_card_rank, next_card_rank
  end

  def next_user
    game_player_question_answers = GamePlayerQuestionAnswer.where(
      game_question_id: @game.current_game_question_id
    ).order("ABS(COALESCE(answer,0) - #{@question.question.answer})", created_at: :asc)

    index = game_player_question_answers.index { |gpqa| gpqa.game_player.user_id == @question.user_id }

    next_user = game_player_question_answers[index + 1].game_player.user_id if game_player_question_answers[index + 1]
    next_user = game_player_question_answers[0].game_player.user_id unless game_player_question_answers[index + 1]

    next_user
  end

  def card_order
    %w[2 3 4 5 6 7 8 9 t j q k a]
  end

  def suit_order
    %w[c d h s]
  end
end
