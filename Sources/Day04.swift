import Algorithms

struct Day04: AdventDay {
    // Save your data in a corresponding text file in the `Data` directory.
    var data: String
    
    // Splits input data into its component parts and convert from string.
    var entities: [String] {
        data.split(separator: "\n").map({ String($0) })
    }
    
    // Replace this with your solution for the first part of the day's challenge.
    func part1() -> Any {
        // Calculate the sum of the first set of input data
        var sum = 0
        for entity in entities {
            let id = getCardId(from: entity)
            let winningNumbers = getWinningNumbers(from: entity)
            let ownNumbers = getOwnNumbers(from: entity)
            
            let card = Card(id: id, winningNumbers: winningNumbers, numbers: ownNumbers)
            
            sum += card.getPoints()
            print("\(card.id) - \(card.getMatchingNumbers()) - \(card.getMatchingNumbers().count) - \(card.getPoints())")
        }
        
        return sum
    }
    
    // Replace this with your solution for the second part of the day's challenge.
    func part2() -> Any {
        // Sum the maximum entries in each set of data

        var allCards = [Card]()
        var cardCounts = Array(repeating: 1, count: entities.count)
        for (index, entity) in entities.enumerated() {
            let id = getCardId(from: entity)
            let winningNumbers = getWinningNumbers(from: entity)
            let ownNumbers = getOwnNumbers(from: entity)
            let card = Card(id: id, winningNumbers: winningNumbers, numbers: ownNumbers)
            allCards.append(card)
            
            if card.getMatchingNumbers().isEmpty { continue }
            for nextCardIndex in 1...card.getMatchingNumbers().count {
                if index + nextCardIndex < entities.count {
                    cardCounts[index + nextCardIndex] += cardCounts[index]
                }
            }
        }
        
        return cardCounts.reduce(0, +)
    }
    
    struct Card {
        let id: Int
        let winningNumbers: [Int]
        let numbers: [Int]
        
        func getMatchingNumbers() -> [Int] {
            return numbers.filter({ winningNumbers.contains($0) })
        }
        
        func getPoints() -> Int {
            if getMatchingNumbers().isEmpty {
                return 0
            }
            var points = 1
            for _ in 1..<getMatchingNumbers().count {
                points = points * 2
            }
            return points
        }
    }
}

extension Day04 {
    private func getCardId(from string: String) -> Int {
        let cardId = string.components(separatedBy: ":")[0]
        let number = cardId.components(separatedBy: " ").last ?? ""
        return Int(number) ?? 0
    }
    
    private func getWinningNumbers(from string: String) -> [Int] {
        guard let colonRange = string.range(of: ":"),
              let pipeRange = string.range(of: "|") else {
            return []
        }
        return string[colonRange.upperBound..<pipeRange.lowerBound]
            .components(separatedBy: " ")
            .compactMap({ Int($0) })
    }
    
    private func getOwnNumbers(from string: String) -> [Int] {
        guard let pipeRange = string.range(of: "|") else {
            return []
        }
        return string[pipeRange.upperBound...]
            .components(separatedBy: " ")
            .compactMap({ Int($0) })
    }
}
