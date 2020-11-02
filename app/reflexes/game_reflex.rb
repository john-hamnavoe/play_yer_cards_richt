# frozen_string_literal: true

class GameReflex < ApplicationReflex
  include CableReady::Broadcaster
  # Add Reflex methods in this file.
  #
  # All Reflex instances expose the following properties:
  #
  #   - connection - the ActionCable connection
  #   - channel - the ActionCable channel
  #   - request - an ActionDispatch::Request proxy for the socket connection
  #   - session - the ActionDispatch::Session store for the current visitor
  #   - url - the URL of the page that triggered the reflex
  #   - element - a Hash like object that represents the HTML element that triggered the reflex
  #   - params - parameters from the element's closest form (if any)
  #
  # Example:
  #
  #   def example(argument=true)
  #     # Your logic here...
  #     # Any declared instance variables will be made available to the Rails controller and view.
  #   end
  #
  # Learn more at: https://docs.stimulusreflex.com

  def start
    change_state(GameState::QUESTION_PLAY)
  end

  def show
    change_state(GameState::QUESTION_ANSWER)
  end

  def bonus
    change_state(GameState::QUESTION_BONUS)
  end

  def leaderboard
    change_state(GameState::QUESTION_TABLE)
  end

private

  def change_state(state)
    game_id = element.dataset["game-id"]
    game = Game.find_by(id: game_id)
    game.game_state = state
    game.save
    cable_ready["game-stream"].dispatch_event name: "game:changed"
    cable_ready.broadcast    
  end
end
