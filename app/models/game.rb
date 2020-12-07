class Game < ApplicationRecord
  belongs_to :user
  belongs_to :current_game_question, class_name: "GameQuestion", optional: true
  has_many :game_players, dependent: :destroy

  before_create :generate_pin

  private

  def generate_pin
    self.pin = rand(100_000..999_999)
    generate_pin if Game.exists?(pin: pin)
  end
end
