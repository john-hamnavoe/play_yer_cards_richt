class DashboardController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @cards = GameQuestion.first.current_cards
    @shown_cards = GameQuestion.first.current_card
    @last_guess_correct = GameQuestion.first.last_guess_correct
  end

  def higher
    @question = GameQuestion.first
    @question.last_guess_correct = next_card_is_higher
    @question.current_card = @question.current_card + 1
    @question.save
    redirect_to dashboard_index_path
  end

  def lower
    @question = GameQuestion.first
    @question.last_guess_correct = next_card_is_lower
    @question.current_card = @question.current_card + 1
    @question.save
    redirect_to dashboard_index_path
  end

  private

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
    next_card = @question.current_cards[@question.current_card+1]
    current_card_rank = card_order.index(current_card[0])
    next_card_rank = card_order.index(next_card[0])
    if (current_card_rank == next_card_rank)
      current_card_rank =  suit_order.index(current_card[1])
      next_card_rank =  suit_order.index(next_card[1])
    end

    return current_card_rank, next_card_rank
  end 

  def card_order
    ["2", "3", "4", "5", "6", "7", "8", "9", "t", "j", "q", "k", "a"]
  end

  def suit_order
    ["c", "d", "h", "s"]
  end  
end
