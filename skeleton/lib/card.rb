class Card 
  # include Comparable
  attr_reader :suit, :value
  def initialize(suit, value)
  end

  def <=>(other_card)
  end

  def color 
  end

  def self.suits
  end

  def self.values
  end

  def self.points_value(card)
  end
end