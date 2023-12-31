import Foundation

struct Concentration {
	
	private(set) var cards = [Card]()
    
    var isGameComplete: Bool {
        return cards.allSatisfy { $0.isMatched }
    }
    
    private var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get{
            var foundIndex: Int?
            for index in cards.indices {
                if cards[index].isFaceUp {
                    if foundIndex == nil {
                        foundIndex=index
                    } else {
                        return nil
                    }
                }
            }
            return foundIndex
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
            
        }
    }
    
	mutating func chooseCard(at index: Int) {
        assert(cards.indices.contains(index),"Concentratioan.chooseCard(at: \(index)): chosen index not in the cards")
		if !cards[index].isMatched {
			if let matchIndex = indexOfTheOneAndOnlyFaceUpCard, matchIndex != index {
				// check if cards match
				if cards[matchIndex] == cards[index]{
					cards[matchIndex].isMatched = true
					cards[index].isMatched = true
                }
				cards[index].isFaceUp = true
			} else {
				indexOfTheOneAndOnlyFaceUpCard = index
			}
		}
	}
    
	init(numberOfPairsOfCards: Int) {
         assert(numberOfPairsOfCards > 0,"Concentratioan.init(\(numberOfPairsOfCards)): you must have at least one pair of cards")
		print("Concentration initializer\(numberOfPairsOfCards)")
        for _ in 1...numberOfPairsOfCards {
			let card = Card()
			cards += [card, card]
	}
		//Shuffle the cards
        cards.shuffle()
	}

}

