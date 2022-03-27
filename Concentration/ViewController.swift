//
//  ViewController.swift
//  Concentration
//
//  Created by Владимир Файб on 26.03.2022.
//

import UIKit

class ViewController: UIViewController {

  lazy var game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
  
  var flipCount = 0 {
    didSet { flipCountLabel.text = "\(flipCount)"}
  }
  
  var emojiChoices = ["👻", "🎃", "👻", "🎃"]
  
  @IBOutlet weak var flipCountLabel: UILabel!
  
  @IBOutlet var cardButtons: [UIButton]!
  
  func configureUI() {
    
  }
  
  func updateViewFromModel() {
    for index in cardButtons.indices {
      let button = cardButtons[index]
      let card = game.cards[index]
      if card.isFaceUp {
        button.setTitle(emoji, for: .normal)
        button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
      }
    }
  }
  
  @IBAction func touchCard(_ sender: UIButton) {
    flipCount += 1
    if let cardNumber = cardButtons.firstIndex(of: sender) {
      game.chooseCard(at: cardNumber)
      updateViewFromModel()
    } else {
      print("chosen card was not in cardButtons")
    }
  }
  
  func flipCard(withEmoji emoji: String, on button: UIButton) {
    if button.currentTitle == emoji {
      button.setTitle("", for: .normal)
      button.backgroundColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
    } else {
      button.setTitle(emoji, for: .normal)
      button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
  }
}

