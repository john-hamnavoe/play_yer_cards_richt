class Game < ApplicationRecord
  belongs_to :user
  has_many :game_players

  before_create :generate_pin

  private

  def generate_pin
    self.pin = rand(100000..999999)
    generate_pin if Game.exists?(pin: self.pin)
  end
end
