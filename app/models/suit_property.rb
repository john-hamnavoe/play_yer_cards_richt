# frozen_string_literal: true

class SuitProperty
  def self.find_by_code(code)
    SuitProperty.all.find { |e| e[:code] == code }
  end

  def self.all
    [
      {
        code: "h",
        css_suit: "hearts",
        span_suit: "hearts"
      },
      {
        code: "c",
        css_suit: "clubs",
        span_suit: "clubs"
      },
      {
        code: "s",
        css_suit: "spades",
        span_suit: "spades"
      },
      {
        code: "d",
        css_suit: "diams",
        span_suit: "diams"
      }
    ]
  end
end
