//
//  Concentration.swift
//  Concentration
//
//  Created by Владимир Файб on 27.03.2022.
//

import Foundation

class Concentration {
  var cards = [Card]()
  
  func chooseCard(at index: Int) {
    
  }
  
  init(numberOfPairsOfCards: Int) {
    for _ in 0..<numberOfPairsOfCards {
      let card = Card()
      cards += [card, card]
    }
    cards.shuffle()
  }
}
