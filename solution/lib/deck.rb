require_relative 'card'
class Deck 

  def initialize(cards = nil)
    @cards = cards || Deck.all_cards
  end

  def self.all_cards 
    all_cards = [] 
    Card.suits.each do |suit|
      Card.values.each do |value|
        all_cards << Card.new(suit, value)
      end
    end
    all_cards
  end

  def count
    @cards.length
  end

  def take(amt = 1)
    raise "Not enough cards!" if amt > count
    cards = [] 
    amt.times { cards << @cards.shift }
    cards 
  end

  def return(cards)
    raise "Only cards can be returned!" unless cards.all? {|card| card.is_a?(Card)}
    @cards.concat(cards)
  end
end