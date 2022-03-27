//
//  Card.swift
//  Concentration
//
//  Created by Владимир Файб on 27.03.2022.
//

import Foundation

struct Card {
  var isFaceUp = false
  var isMatched = false
  var identifier: Int
  static var  identifierFactory = 0
  static func getUniqueIdentifier() -> Int {
    identifierFactory += 1
    return identifierFactory
  }
  
  init() {
    identifier = Card.getUniqueIdentifier()
  }
}
