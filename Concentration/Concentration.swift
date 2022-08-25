//
//  Concentration.swift
//  Concentration
//
//  Created by Владимир Файб on 27.03.2022.
//

import Foundation

class Concentration {
  var cards = [Card]()
  var flipCount = 0
  var indexOfOneAndOnlyFaceUpCard: Int?
  
  func chooseCard(at index: Int) {
    if !cards[index].isMatched {
      if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
        if cards[matchIndex].identifier == cards[index].identifier {
          cards[matchIndex].isMatched = true
          cards[index].isMatched = true
        }
        cards[index].isFaceUp = true
        indexOfOneAndOnlyFaceUpCard = nil
      } else {
        for i in cards.indices {
          cards[i].isFaceUp = false
        }
        cards[index].isFaceUp = true
        indexOfOneAndOnlyFaceUpCard = index
      }
    }
    flipCount += 1
  }
  
  init(numberOfPairsOfCards: Int) {
    for _ in 0..<numberOfPairsOfCards {
      let card = Card()
      cards += [card, card]
    }
    shuffleCards()
  }
  func shuffleCards() {
    for i in cards.indices {
      cards[i].isFaceUp = false
      cards[i].isMatched = false
    }
    flipCount = 0
    cards.shuffle()
  }
}
