require 'rspec'
require 'card'

describe Card do 
  subject(:card) { Card.new(:spades, :queen) }

  describe '#initialize' do 
    it 'sets the suit of the card' do 
      expect(card.suit).to be(:spades)
    end 
    
    it 'sets the value of the card' do 
      expect(card.value).to be(:queen)
    end 

    it 'raises "Invalid Suit/Value" for invalid suits/values' do 
      expect {Card.new(:bulbasaur, :two)}.to raise_error("Invalid Suit/Value")
    end
  end 

  describe '#<=>' do 
    
    let(:numeric_card1) { Card.new(:hearts, :two ) }
    let(:numeric_card2) { Card.new(:diamonds, :four) }
    let(:ace) { Card.new(:spades, :ace) }
    let(:face_card) { Card.new(:clubs, :jack) }
    
    it 'works for numeric value cards' do 
      expect(numeric_card1<=>(numeric_card2)).to eq(-1)
    end 

    it 'works with face cards' do 
      expect(face_card<=>(numeric_card2)).to eq(1)
    end 

    it 'counts aces as low' do 
      expect(numeric_card1<=>(ace)).to eq(1)
    end

    it 'includes Comparable module' do 
      expect(numeric_card1==(numeric_card2)).to be(false)
      expect(numeric_card1.between?(ace,numeric_card2)).to be true 
    end

  end 

  describe "#color" do 
    it "returns :red for diamonds and hearts" do
      expect(Card.new(:hearts, :ten).color).to be :red 
      expect(Card.new(:diamonds, :ten).color).to be :red 
    end 

    it "returns :black for spades and clubs" do 
      expect(Card.new(:clubs, :ten).color).to be :black
      expect(Card.new(:spades, :ten).color).to be :black
    end
  end 
      
end
