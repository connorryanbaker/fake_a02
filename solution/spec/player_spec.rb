require 'rspec'
require 'player'
require 'deck'
require 'hand'

describe Player do 
  subject(:deck) { Deck.new }
  subject(:player) { Player.new(deck)}

  describe '#initialize' do

    it 'sets @hand equal to Hand::deal_from(deck)' do 
      new_hand = Hand.deal_from(Deck.new)
      bool = true 
      new_hand.cards.each_with_index do |card, i|
        if player.hand.cards[i].color != card.color || player.hand.cards[i].value != card.value 
          bool = false 
        end
      end
      expect(bool).to be true
    end
  end

  describe '#play_card' do 
    let(:card) { Card.new(:spades, :queen) }
    let(:hand) { double("hand", :discard => card, :draw => card) }
    it 'should raise error if card with passed suit/value does not exist in hand' do 
      expect { player.play_card(:spades, :joker) }.to raise_error("No such card!")
    end 

    it 'delegates to Hand#discard' do 
      player.hand = hand 
      expect(hand).to receive(:discard).with(:spades, :queen).and_return(card)
      player.play_card(:spades, :queen)
    end 
  end

  describe "#draw" do 
    let(:card) { Card.new(:spades, :queen) }
    let(:hand) { double("hand", :discard => card, :draw => card) }
    it 'delegates to Hand#draw' do 
      deck = double("deck")
      expect(hand).to receive(:draw).with(deck).and_return(card)
      player.hand = hand 
      player.draw(deck) 
    end
  end 
end 
