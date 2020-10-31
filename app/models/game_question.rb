class GameQuestion < ApplicationRecord
  belongs_to :game
  belongs_to :question
  belongs_to :user, optional: true

  before_create :generate_shuffled_deck

  private

  def generate_shuffled_deck
    shuffled_deck = ["2s", "3s", "4s", "5s", "6s", "7s", "8s", "9s", "ts", "js", "qs", "ks", "as",
                 "2c", "3c", "4c", "5c", "6c", "7c", "8c", "9c", "tc", "jc", "qc", "kc", "ac",
                 "2d", "3d", "4d", "5d", "6d", "7d", "8d", "9d", "td", "jd", "qd", "kd", "ad",
                 "2h", "3h", "4h", "5h", "6h", "7h", "8h", "9h", "th", "jh", "qh", "kh", "ah"].shuffle
    self.current_cards = shuffled_deck[0..5]
    self.card_deck = shuffled_deck[6..52]
  end
end
