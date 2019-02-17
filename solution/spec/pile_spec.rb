require 'rspec'
require 'pile'
require 'card'

describe Pile do 
  describe '#initialize' do 
    let(:card) { Card.new(:spades, :queen) }
    let(:pile) { Pile.new(card) }
    context "when initialized with a card" do 
      it 'sets reader for :bottom_card' do 
        expect(pile.bottom_card).to eq(card)
      end

      it 'sets an instance variable for @cards' do 
        expect(pile.instance_variable_get(:@cards)).to eq([card])
      end

      it 'raises an error if initialized with anything but a single card' do 
        expect { Pile.new([Card.new(:spades, :queen), Card.new(:diamonds, :king)]) }.to raise_error("Piles are initialized with one card!")
      end
    end 

    context "when initialized with no arguments" do 
      it 'still responds to bottom_card and top_card' do 
        pile = Pile.new
        expect(pile.bottom_card).to be nil 
      end 

      it 'sets the instance variable @cards to an empty array' do 
        pile = Pile.new
        expect(pile.instance_variable_get(:@cards)).to eq([])
      end 
    end 
  end

  describe "#top_card" do 
    it 'returns the last card in the cards array' do 
      card = Card.new(:spades, :queen)
      pile = Pile.new(card)
      expect(pile.top_card).to eq(card)
    end

    it 'returns nil when empty' do 
      pile = Pile.new 
      expect(pile.top_card).to be nil 
    end 
  end

  describe "#empty?" do 
    it "returns true when @cards == []" do 
      pile = Pile.new 
      expect(pile.empty?).to be true 
    end

    it "returns false when there are cards in the pile" do 
      pile = Pile.new(Card.new(:diamonds, :ten))
      expect(pile.empty?).to be false 
    end
  end 

  describe "#valid_card?" do 
    let(:red_card) { Card.new(:diamonds, :nine) }
    let(:black_card) { Card.new(:spades, :queen) }
    let(:red_pile) { Pile.new(red_card) }
    let(:black_pile) { Pile.new(black_card) }

    it "returns true when the pile is empty" do 
      pile = Pile.new 
      expect(pile.valid_card?(red_card)).to be true 
    end

    it "returns true when passed a card with valid color and value" do 
      card = Card.new(:diamonds, :jack)
      expect(black_pile.valid_card?(card)).to be true 
    end

    it "returns false when passed a card with valid color but invalid value" do 
      expect(black_pile.valid_card?(red_card)).to be false 
    end

    it "returns false when passed a card with invalid color but valid value" do 
      card = Card.new(:hearts, :eight)
      expect(red_pile.valid_card?(card)).to be false 
    end
  end

  describe "#merge" do 
    let(:pile_one) { Pile.new(Card.new(:diamonds, :queen)) }
    let(:pile_two) { Pile.new(Card.new(:spades, :jack)) }

    it "raises an error for invalid merges" do 
      expect { pile_one.merge(Pile.new(Card.new(:spades, :ten))) }.to raise_error("Invalid merge!")
    end

    it "adds to the cards array of the receiver of #merge" do 
      pile_one.merge(pile_two)
      expect(pile_one.instance_variable_get(:@cards).length).to eq(2)
    end
    
    it "clears the cards array of the pile passed into the method" do 
      pile_one.merge(pile_two)
      expect(pile_two.instance_variable_get(:@cards).length).to eq(0)
    end
  end 

  describe "#add_card" do 
    let(:pile_one) { Pile.new(Card.new(:diamonds, :queen)) }
    let(:valid_card) { Card.new(:spades, :jack) }
    let(:invalid_card) { Card.new(:diamonds, :jack) }

    it "raises an error if card is invalid" do 
      expect { pile_one.add_card(invalid_card) }.to raise_error("Invalid card!")
    end 

    it "adds valid cards to the cards array" do 
      pile_one.add_card(valid_card)
      expect(pile_one.cards.length).to be 2 
    end

    it "adds the valid card to the top of the pile" do 
      pile_one.add_card(valid_card)
      expect(pile_one.top_card).to eq(valid_card)
    end
  end
end 

describe KingPile do 
  subject(:pile) { KingPile.new }
  describe "#initialize" do 
    it "inherits from Pile" do
      expect(pile.is_a?(Pile)).to be true 
    end
    
    it "sets cards to empty array and bottom card to nil" do 
      expect(pile.bottom_card).to be nil 
      expect(pile.cards).to eq([])
    end
  end

  describe "#valid_card?" do 
    it "returns false when empty and card is not a king" do 
      expect(pile.valid_card?(Card.new(:spades, :queen))).to be false 
    end

    it "returns true when empty and card is a king" do 
      expect(pile.valid_card?(Card.new(:spades, :king))).to be true 
    end

    it "otherwise delegates to super" do 
      pile.add_card(Card.new(:spades, :king))
      expect(pile.valid_card?(Card.new(:diamonds, :queen))).to be true 
      expect(pile.valid_card?(Card.new(:diamonds, :ten))).to be false 
    end
  end

  describe "#merge" do 
    it "raises an error if empty" do 
      expect { pile.merge(Pile.new(Card.new(:spades, :queen))) }.to raise_error("Invalid merge!")
    end
  end
end


