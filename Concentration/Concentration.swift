import Foundation

struct Concentration {
    private(set) var cards = [Card]()
    private(set) var flipCount = 0
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            cards.indices.filter{ cards[$0].isFaceUp }.oneAndOnly
        }
        set {
            for i in cards.indices {
                cards[i].isFaceUp = i == newValue
            }
        }
    }

    mutating func chooseCard(at index: Int) {
        assert(
            cards.indices.contains(index),
            "Concentration.chooseCard(at: \(index)): chosen index not in the cards"
        )
        if !cards[index].isMatched,
            !cards[index].isFaceUp {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, 
                matchIndex != index {
                if cards[matchIndex] == cards[index] {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
            } else {
                indexOfOneAndOnlyFaceUpCard = index
            }
            flipCount += 1
        }
    }

    init(numberOfPairsOfCards: Int) {
        assert(
            numberOfPairsOfCards > 0,
            "Concentration.init(numberOfPairsOfCards: \(numberOfPairsOfCards)): you must have at least one pair of cards"
        )
        for _ in 0..<numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        shuffleCards()
    }

    mutating func shuffleCards() {
        for i in cards.indices {
            cards[i].isFaceUp = false
            cards[i].isMatched = false
        }
        flipCount = 0
        cards.shuffle()
    }
}

extension Collection {
    var oneAndOnly: Element? {
        self.count == 1 ? first : nil
    }
}
