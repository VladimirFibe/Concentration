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
  
  @IBOutlet weak var flipCountLabel: UILabel!
  
  @IBOutlet var cardButtons: [UIButton]!
  
  var emojiChoices = ["👻", "👽", "😻", "👿", "🤠", "🤖", "🧛‍♂️", "🧙‍♀️", "🦇", "🎃"]
  var emoji = [Int: String]()
  func emoji(for card: Card) -> String {
    if let chosenEmoji = emoji[card.identifier] {
      return chosenEmoji
    } else if emojiChoices.isEmpty {
      return "👻"
    } else {
      let chosenEmoji = emojiChoices.removeLast()
      emoji[card.identifier] = chosenEmoji
      return chosenEmoji
    }
  }
  
  func configureUI() {
    
  }
  
  func updateViewFromModel() {
    for index in cardButtons.indices {
      let button = cardButtons[index]
      let card = game.cards[index]
      if card.isFaceUp {
        button.setTitle(emoji(for: card), for: .normal)
        button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
      } else {
        button.setTitle("", for: .normal)
        button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
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
  
  override func viewDidLoad() {
    super.viewDidLoad()
    cardButtons.forEach {
      $0.setTitle("", for: .normal)
      $0.titleLabel?.font = .systemFont(ofSize: 100)
    }
  }
}

