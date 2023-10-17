import Foundation

struct Card: Hashable, Equatable {
    var isFaceUp = false
    var isMatched = false
    private var identifier: Int
    private static var  identifierFactory = 0
    private static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }

    init() {
        identifier = Card.getUniqueIdentifier()
    }

    static func ==(lhs: Self, rhs: Self) -> Bool {
        lhs.identifier == rhs.identifier
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
}
