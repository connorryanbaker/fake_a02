require 'rspec'
require 'hand'
require 'card'

describe Hand do 
  describe "::deal_from" do 
    it "deals a hand of seven cards from a deck" do 
      cards = [Card.new(:spades, :king), Card.new(:diamonds, :two), Card.new(:hearts, :queen), 
      Card.new(:clubs, :ace), Card.new(:spades, :ten), Card.new(:clubs, :jack), Card.new(:hearts, :five)]
      deck = double("deck")
      expect(deck).to receive(:take).with(7).and_return(cards)

      hand = Hand.deal_from(deck)
      expect(hand.cards).to match_array(cards)
    end 
  end 

  describe "#points" do 
    it "counts kings as ten points" do 
      hand = Hand.new([Card.new(:diamonds, :king), Card.new(:spades, :king)])
      expect(hand.points).to be(20)
    end 

    it "counts all other cards as one point" do 
      hand = Hand.new([Card.new(:spades, :ace), Card.new(:diamonds, :ten)])
      expect(hand.points).to be(2)
    end
  end 

  describe "#discard" do 
    let(:card) { Card.new(:spades, :queen) }
    let(:hand) { Hand.new([Card.new(:diamonds, :king), card]) }
    it 'returns the card with matching suit and value' do 
      expect(hand.discard(:spades, :queen)).to be(card)
    end

    it 'removes the card from the hand' do 
      hand.discard(:spades, :queen)
      expect(hand.cards.include?(card)).to be false 
    end

    it 'raises an error if there is no matching card' do 
      hand = Hand.new 
      expect { hand.discard(:spades, :ten) }.to raise_error("No such card!")
    end
  end 

  describe "#draw" do 
    it 'takes one card from the deck' do 
      deck = double("deck")
      card = Card.new(:spades, :ace)
      hand = Hand.new
      expect(deck).to receive(:take).with(1).and_return(card)
      hand.draw(deck)
      expect(hand.cards.include?(card)).to be true 
    end
  end 

  describe "#return cards" do 
    it 'returns cards to the deck' do 
      deck = double("deck")
      hand = Hand.new([Card.new(:spades, :queen)])
      expect(deck).to receive(:return).with(hand.cards)
      hand.return_cards(deck)
      expect(hand.cards).to eq([])
    end
  end
end


