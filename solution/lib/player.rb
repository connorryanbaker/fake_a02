require_relative "hand"
class Player
  attr_accessor :hand 
  def initialize(deck)
    @hand = Hand.deal_from(deck)
  end 

  def play_card(suit, value)
    hand.discard(suit, value)
  end

  def draw(deck)
    hand.draw(deck)
  end
end