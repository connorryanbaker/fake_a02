require 'rspec'
require 'deck'

describe Deck do 

  subject(:deck) { Deck.new }


  describe 'initialize' do 
    context 'when called with no arguments' do 
      let(:cards) { deck.instance_variable_get(:@cards) }
      it 'sets cards to return value of Deck.all_cards' do 
        bool, new_deck = true, Deck.all_cards 
        (0..51).each {|i| bool = false if cards[i] != new_deck[i]}
        expect(bool).to be(true)
        expect(cards.length).to be(52)
      end 
    end 

    context 'when called with optional argument' do 

      it 'sets cards equal to whatever is passed to it' do 
        poke_deck = Deck.new([:bulbasaur])
        expect(poke_deck.instance_variable_get(:@cards)).to eq([:bulbasaur])
      end  
    end 

    it 'does not expose cards instance variable' do 
      expect { deck.cards }.to raise_error(NoMethodError)
    end
  end 
  
  describe '::all_cards' do
    let(:cards) { Deck.all_cards }
    it 'creates a deck of length 52' do 
      expect(cards.length).to be(52)
    end

    it 'creates a deck of all unique cards with 4 suits and 13 values' do
      expect(cards.uniq.length).to be(52)
      expect(cards.map(&:suit).uniq.length).to be(4)
      expect(cards.map(&:value).uniq.length).to be(13)
    end 
  end

  describe '#count' do 
    it 'returns the length of the cards array' do 
      expect(deck.count).to eq(52)
    end
  end

  describe '#take' do 
    let(:deck_2) { Deck.new }
    let(:cards) { deck.instance_variable_get(:@cards) }
    it 'by default takes one card from the top of the deck' do 
      expect(deck_2.take).to eq([cards[0]])
    end

    it 'takes optional arguments of how many cards to take' do 
      expect(deck_2.take(7)).to eq(cards[0..6])
    end 

    it 'raises an error if the argument is an invalid number' do 
      expect { deck_2.take(77) }.to raise_error('Not enough cards!')
    end 
  end
  
  describe '#return' do 
    let(:some_cards) { [Card.new(:spades, :ten), Card.new(:hearts, :ace)]}
    let(:little_deck) { Deck.new([Card.new(:diamonds, :nine)])}
    
    it 'adds the cards to the bottom of the deck' do 
      little_deck.return(some_cards)
      expect(little_deck.instance_variable_get(:@cards)[1..2]).to eq(some_cards)
      expect(little_deck.count).to eq(3)
    end

    it 'raises an error if the argument contains anything but cards' do 
      expect { little_deck.return([:one_carrot, :and_a_rock]) }.to raise_error("Only cards can be returned!")
    end 

  end
  
end