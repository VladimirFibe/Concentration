import UIKit

class ConcentrationViewController: VCLLoggingViewController {

    var numberOfPairsOfCards: Int {
        (cardButtons.count + 1) / 2
    }

    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)

    private var flipCountLabel: UILabel = {
        return $0
    }(UILabel())

    private var cardButtons: [UIButton] = []
    var theme: String? {
        didSet {
            emojiChoices = theme ?? "👻🎃🤡💀🤖🤠😹😈"
            emoji = [:]
            updateViewFromModel()
        }
    }
    private var emojiChoices = "👻👽😻👿🤠🤖🧛‍♂️🧙‍♀️🦇🎃"
    private var emoji = [Card: String]()

    private func emoji(for card: Card) -> String {
        if let chosenEmoji = emoji[card] {
            return chosenEmoji
        } else if emojiChoices.isEmpty {
            return "👻"
        } else {
            let randomStringIndex = emojiChoices.index(emojiChoices.startIndex, offsetBy: emojiChoices.count.arc4random)
            let chosenEmoji = String(emojiChoices.remove(at: randomStringIndex))
            emoji[card] = chosenEmoji
            return chosenEmoji
        }
    }

    private let stackView: UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.distribution = .fillEqually
        $0.spacing = 8
        $0.axis = .vertical
        return $0
    }(UIStackView())

    private func updateViewFromModel() {
        guard !cardButtons.isEmpty else { return }

        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: .normal)
                button.backgroundColor = UIColor.white
            } else {
                button.setTitle("", for: .normal)
                button.backgroundColor = card.isMatched ? .clear : .orange
            }
        }
        let attributes: [NSAttributedString.Key: Any] = [
            .strokeColor: UIColor.orange,
            .strokeWidth: 5
        ]
        let attibutedText = NSAttributedString(string: "Flips: \(game.flipCount)", attributes: attributes)
        flipCountLabel.attributedText = attibutedText
    }

    @objc private func newGame(_ sender: Any) {
        game.shuffleCards()
        updateViewFromModel()
    }

    @objc private func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("chosen card was not in cardButtons")
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        updateViewFromModel()
    }
}

extension ConcentrationViewController {
    private func setupViews() {
        view.addSubview(stackView)
        setupCardButtons()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor)
        ])
    }

    private func setupCardButtons() {
        for _ in 0..<4 {
            let rowStackView = UIStackView()
            rowStackView.spacing = 8
            rowStackView.distribution = .fillEqually
            for _ in 0..<4 {
                let button = UIButton(type: .system)
                button.addTarget(self, action: #selector(touchCard), for: .primaryActionTriggered)
                button.titleLabel?.font = .systemFont(ofSize: 50)
                cardButtons.append(button)
                rowStackView.addArrangedSubview(button)
            }
            stackView.addArrangedSubview(rowStackView)
        }
        stackView.addArrangedSubview(flipCountLabel)
    }
}

extension Int {
  var arc4random: Int {
      (self > 0) ? Int.random(in: 0..<self) : self
  }
}
