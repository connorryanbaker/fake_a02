class Pile
  attr_reader :bottom_card, :cards

  def initialize(card = nil)
  end

  def top_card
  end

  def empty?
  end

  def valid_card?(card)
  end

  def merge(pile)
  end

  def add_card(card)
  end

  protected
  def clear_pile
  end

end

class KingPile < Pile 
  def initialize 
  end

  def valid_card?(card)
  end

  def add_card(card)
  end
end