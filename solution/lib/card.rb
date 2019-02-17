class Card 
  include Comparable
  attr_reader :suit, :value
  def initialize(suit, value)
    raise 'Invalid Suit/Value' unless Card.suits.include?(suit) && Card.values.include?(value)
    @suit, @value = suit, value
  end

  def <=>(other_card)
    Card.points_value(self) <=> Card.points_value(other_card)
  end

  def color 
    [:clubs, :spades].include?(suit) ? :black : :red 
  end

  def self.suits
    [:spades, :hearts, :clubs, :diamonds]
  end

  def self.values
    [:ace, :two, :three, :four, :five, :six, :seven,
     :eight, :nine, :ten, :jack, :queen, :king]
  end

  def self.points_value(card)
    values = { ace: 1, two: 2, three: 3, four: 4, five: 5, six: 6, seven: 7,
              eight: 8, nine: 9, ten: 10, jack: 10, queen: 10, king: 10 }
    values[card.value]
  end
end