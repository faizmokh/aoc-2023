import Algorithms

struct Day03: AdventDay {
    // Save your data in a corresponding text file in the `Data` directory.
    var data: String
    
    let arrayOfSymbols: [Character] = ["*", "$", "+", "#", "@", "&", "!", "%", "^", "~", "(", ")", "}", "{", "]", "[", "-", "/", "=", "_", "|", "\\", ">", "<", "?", ":", ";", ","]
    
    // Splits input data into its component parts and convert from string.
    var entities: [[Character]] {
        return data
            .components(separatedBy: "\n")
            .map({ $0.map({ $0 }) })
    }
    
    // Replace this with your solution for the first part of the day's challenge.
    func part1() -> Any {
        // Calculate the sum of the first set of input data
        var allNumbers = [Number]()
        for (y, line) in entities.enumerated() {
            let numbers = getNumbersAndPosition(line: line, y: y)
            allNumbers.append(contentsOf: numbers)
        }
        
        var validNumbers = [Number]()
        for number in allNumbers {
            let adjacentPositions = getAdjacentPositionsFor(number: number)
            if isSymbolsExist(entities: entities, positions: adjacentPositions) {
                validNumbers.append(number)
            }
        }
        
        let sum = validNumbers.reduce(0, { $0 + $1.intValue })
        
        return sum
    }
    
    // Replace this with your solution for the second part of the day's challenge.
    func part2() -> Any {
        // Sum the maximum entries in each set of data
        return 0
    }
    
    struct Number {
        let value: String
        let positions: [Position]
        
        var intValue: Int {
            return Int(value) ?? 0
        }
    }
    
    struct Position: Equatable, Hashable {
        let x: Int
        let y: Int
        
        static func == (lhs: Position, rhs: Position) -> Bool {
            return lhs.x == rhs.x && lhs.y == rhs.y
        }
    }
}

extension Day03 {
    // loop through the line and find numbers and their positions
    private func getNumbersAndPosition(line: [Character], y: Int) -> [Number] {
        var numbers = [Number]()
        
        var currentNumber = ""
        var positions = [Position]()

        for (x, character) in line.enumerated() {
            let isLastCharacter = x == line.count - 1
            if character.isNumber {
                currentNumber.append(character)
                positions.append(Position(x: x, y: y))
            } else if !character.isNumber {
                // if have reached the end of the line or the character is not a number
                if !currentNumber.isEmpty {
                    numbers.append(Number(value: currentNumber, positions: positions))
                    currentNumber = ""
                    positions.removeAll()
                }
            }
            
            if isLastCharacter {
                if !currentNumber.isEmpty {
                    numbers.append(Number(value: currentNumber, positions: positions))
                    currentNumber = ""
                    positions.removeAll()
                }
            }
        }
        return numbers
    }
    
    private func getAdjacentPositionsFor(number: Number) -> [Position] {
        var positions = [Position]()
        
        let directions: [(x: Int, y: Int)] = [
            (-1, 1),  (0, 1),  (1, 1),
            (-1, 0),           (1, 0),
            (-1, -1), (0, -1), (1, -1)
        ]
        
        for position in number.positions {
            for direction in directions {
                let x = position.x + direction.x
                let y = position.y + direction.y
                positions.append(Position(x: x, y: y))
            }
        }
        
        var filteredPositions = [Position]()
        
        for position in positions {
            if !number.positions.contains(where: { $0.x == position.x && $0.y == position.y }) {
                filteredPositions.append(position)
            }
        }
        
        return Array(Set(filteredPositions))
    }
    
    private func isSymbolsExist(entities: [[Character]], positions: [Position]) -> Bool {
        let row = entities[0].count
        let column = entities.count - 1

        for position in positions {
            if position.x >= 0 && position.x < row && position.y >= 0 && position.y < column {
                let char = entities[position.y][position.x]
                if arrayOfSymbols.contains(char) {
                    return true
                }
            }
        }
        return false
    }
}

