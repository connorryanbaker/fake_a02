class Hand
  attr_accessor :cards 
  def self.deal_from(deck)
    cards = deck.take(7)
    Hand.new(cards)
  end

  def initialize(cards = nil)
    @cards = cards || []
  end

  def points 
    cards.inject(0) do |acc, card|
      if card.value == :king 
        acc += 10 
      else 
        acc += 1 
      end
    end
  end

  def discard(suit, value)
    card = cards.find {|card| card.suit == suit && card.value == value}
    raise "No such card!" if card.nil?
    self.cards = cards.reject {|c| card.suit == suit && card.value == value}
    card 
  end

  def draw(deck)
    cards << deck.take(1)
  end

  def return_cards(deck)
    deck.return(self.cards)
    self.cards.clear
  end
end