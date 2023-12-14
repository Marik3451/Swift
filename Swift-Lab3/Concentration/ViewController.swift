import UIKit

class ViewController: UIViewController {
    
    private lazy var game:Concentration =
        Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    
    var numberOfPairsOfCards: Int {
        let result = cardButtons.filter({
            $0.alpha == 1.0
        }).count
        return (result + 1) / 2
    }
    
    private(set) var flipCount = 0 {
        didSet {
            updateFlipCountLabel()
        }
    }
    private func updateFlipCountLabel() {
        let attributes: [NSAttributedStringKey: Any] = [
            .strokeWidth: 5.0,
            .strokeColor: #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
        ]
        let attributedString = NSAttributedString(string: "Flips: \(flipCount)",
            attributes: attributes)
        
        flipCountLabel.attributedText = attributedString
    }
    
    @IBOutlet private weak var flipCountLabel: UILabel!
    
    @IBOutlet private var cardButtons: [UIButton]!
    
    
    @IBAction private func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("choosen card was not in cardButtons")
        }
    }
    
    @IBAction private func increaseNumberOfPairs() {
        // Implement logic to increase the number of pairs
        game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards + 1)
        guard game.cards.count<=12 else {return}
        updateButtonsVisibility()
        updateViewFromModel()
        print("Increase \(game.cards.count)")
    }
    
    @IBAction private func decreaseNumberOfPairs() {
        // Implement logic to decrease the number of pairs (ensure it's not less than 1)
        let newNumberOfPairs = max(1, numberOfPairsOfCards - 1)
        game = Concentration(numberOfPairsOfCards: newNumberOfPairs)
        updateViewFromModel()
        guard game.cards.count>=2 else {return}
        updateButtonsVisibility()
        print("Decrease \(game.cards.count)")
    }
    
    private func updateButtonsVisibility(){
        for index in cardButtons.indices{
            if index < game.cards.count{
                cardButtons[index].alpha=1.0
            }else{
                cardButtons[index].alpha=0.0
            }
        }
    }
    
    private func updateViewFromModel() {
        for index in 0..<game.cards.count {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            } else {
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
        }
        if game.isGameComplete {
            // Display a message when the game is complete
            let flips = flipCount == 1 ? "flip" : "flips"
            let message = "Congratulations! You won with \(flipCount) \(flips)."
            let alertController = UIAlertController(title: "Game Over", message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(okAction)
            present(alertController, animated: true, completion: nil)
        }
    }
    
    //private var emojiChoices = ["🦇", "😱", "🙀", "😈", "🎃", "👻", "🍭", "🍬", "🍎"]
    //  private var emojiChoices = ["🦇😱🙀😈🎃👻🍭🍬🍎"]
    private var emojiChoices = ["🦇", "😱", "🙀", "😈", "🎃", "👻", "🍭", "🍬", "🍎"]
    
    private var emoji = [Card: String]()
    
    private func emoji(for card: Card) -> String {
        if emoji[card] == nil, emojiChoices.count > 0 {
            let randomIndex = emojiChoices.count.arc4Random
            emoji[card] = emojiChoices.remove(at: randomIndex)
        }
        //if emoji[card] == nil, emojiChoices.count > 0 {
       //     let stringIndex = emojiChoices.index(emojiChoices.startIndex, offsetBy: emojiChoices.count.arc4Random)
       //     emoji[card] = String(emojiChoices.remove(at: stringIndex))
      //  }
        return emoji[card] ?? "?"
    }
}

extension Int {
    var arc4Random: Int {
        switch self {
        case 1...Int.max:
            return Int(arc4random_uniform(UInt32(self)))
        case -Int.max..<0:
            return Int(arc4random_uniform(UInt32(self)))
        default:
            return 0
        }
        
    }
}
