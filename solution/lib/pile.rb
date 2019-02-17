require 'byebug'
class Pile
  attr_reader :bottom_card, :cards

  def initialize(card = nil)
    raise "Piles are initialized with one card!" if card && !card.is_a?(Card)
    @bottom_card = card 
    @cards = [card].compact 
  end

  def top_card
    @cards.last
  end

  def empty?
    @cards.length == 0 
  end

  def valid_card?(card)
    return true if empty?
    (Card.values.index(top_card.value) - Card.values.index(card.value) == 1) && (top_card.color != card.color)
  end

  def merge(pile)
    if valid_card?(pile.bottom_card)
      @cards.concat(pile.cards)
      pile.clear_pile
    else 
      raise "Invalid merge!"
    end
  end

  def add_card(card)
    raise "Invalid card!" unless valid_card?(card)
    @cards << card 
  end

  protected
  def clear_pile
    @cards = [] 
  end

end

class KingPile < Pile 
  def initialize 
    @bottom_card = nil 
    @cards = []
  end

  def valid_card?(card)
    return false if empty? unless card.value == :king 
    super 
  end

  def add_card(card)
    super 
    @bottom_card = card if cards.length == 1 
  end
end