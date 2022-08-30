//
//  ViewController.swift
//  Concentration
//
//  Created by Владимир Файб on 26.03.2022.
//

import UIKit

class ViewController: UIViewController {

  var numberOfPairsOfCards: Int {
    (cardButtons.count + 1) / 2
  }
  private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
  
  @IBOutlet private weak var flipCountLabel: UILabel!
  
  @IBOutlet private var cardButtons: [UIButton]!
  
  private var emojiChoices = "👻👽😻👿🤠🤖🧛‍♂️🧙‍♀️🦇🎃"
  private var emoji = [Int: String]()
  
  private func emoji(for card: Card) -> String {
    if let chosenEmoji = emoji[card.identifier] {
      return chosenEmoji
    } else if emojiChoices.isEmpty {
      return "👻"
    } else {
      print(emojiChoices, emojiChoices.count)
      let randomStringIndex = emojiChoices.index(emojiChoices.startIndex, offsetBy: emojiChoices.count.arc4random)
      let chosenEmoji = String(emojiChoices.remove(at: randomStringIndex))
      emoji[card.identifier] = chosenEmoji
      return chosenEmoji
    }
  }
  
  private func updateViewFromModel() {
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
    let attributes: [NSAttributedString.Key: Any] = [
      .strokeColor: UIColor.orange,
      .strokeWidth: 5
    ]
    let attibutedText = NSAttributedString(string: "Flips: \(game.flipCount)", attributes: attributes)
    flipCountLabel.attributedText = attibutedText
  }
  
  @IBAction private func newGame(_ sender: Any) {
    game.shuffleCards()
    updateViewFromModel()
  }
  
  @IBAction private func touchCard(_ sender: UIButton) {
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
    updateViewFromModel()
  }
}

extension Int {
  var arc4random: Int {
    (self > 0) ? Int(arc4random_uniform(UInt32(self))) : self
  }
}
