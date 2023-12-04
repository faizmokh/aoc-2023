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
            let adjacentPositions = number.getAdjacentPositions()
            if isSymbolsExist(entities: entities, positions: adjacentPositions) {
                validNumbers.append(number)
            }
        }
        
        let sum = validNumbers.reduce(0, { $0 + $1.intValue })
        
        return sum
    }
    
    
    // Replace this with your solution for the second part of the day's challenge.
    func part2() -> Any {
        var allNumbers = [Number]()
        var allGears = [Gear]()
        for (y, line) in entities.enumerated() {
            let numbers = getNumbersAndPosition(line: line, y: y)
            let gears = getGearsPosition(line: line, y: y)
            allNumbers.append(contentsOf: numbers)
            allGears.append(contentsOf: gears)
        }
        
        var sum = 0
        for gear in allGears {
            // find all numbers that are adjacent to the gear
            let adjacentGearPositions = gear.getAdjacentPositions()
            
            // check if all numbers are adjacent to the gear, if so return the number
            let adjacentNumbers = allNumbers.filter({ $0.positions.contains(where: { adjacentGearPositions.contains($0) }) })
            let uniqueNumbers = Array(Set(adjacentNumbers))
            if uniqueNumbers.count != 2 { continue }

            let product = uniqueNumbers.reduce(1, { $0 * $1.intValue })
            sum += product
        }
        
        return sum
    }
    
    // MARK: - Data
    
    struct Gear {
        let position: Position
        
        func getAdjacentPositions() -> [Position] {
            let adjacents: [(x: Int, y: Int)] = [
                (-1, -1), (0, -1), (1, -1),
                (-1, 0),         (1, 0),
                (-1, 1), (0, 1), (1, 1)
            ]
            
            var adjacentPositions = [Position]()
            for adjacent in adjacents {
                let x = position.x + adjacent.x
                let y = position.y + adjacent.y
                
                guard x >= 0 && y >= 0 else { continue }
                let adjacentPosition = Position(
                    x: position.x + adjacent.x,
                    y: position.y + adjacent.y
                )
                adjacentPositions.append(adjacentPosition)
            }
            
            return Array(Set(adjacentPositions))
        }
    }
    
    struct Number: Equatable, Hashable {
        let value: String
        let positions: [Position]
        
        var intValue: Int {
            return Int(value) ?? 0
        }
                
        func getAdjacentPositions() -> [Position] {
            let adjacents: [(x: Int, y: Int)] = [
                (-1, -1), (0, -1), (1, -1),
                (-1, 0),         (1, 0),
                (-1, 1), (0, 1), (1, 1)
            ]
            
            var adjacentPositions = [Position]()
            for position in positions {
                for adjacent in adjacents {
                    let x = position.x + adjacent.x
                    let y = position.y + adjacent.y
                    
                    guard x >= 0 && y >= 0 else { continue }
                    let adjacentPosition = Position(
                        x: position.x + adjacent.x, 
                        y: position.y + adjacent.y
                    )
                    adjacentPositions.append(adjacentPosition)
                }
            }

            // remove adjacent position that overlaps with the number
            let nonOverlapsPositions = adjacentPositions.filter({ !positions.contains($0) })
            
            return Array(Set(nonOverlapsPositions))
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
    private func getGearsPosition(line: [Character], y: Int) -> [Gear] {
        var gears = [Gear]()
        
        for (x, character) in line.enumerated() {
            if character == "*" {
                let position = Position(x: x, y: y)
                gears.append(Gear(position: position))
            }
        }
        return gears
    }
    
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
    
    private func isSymbolsExist(entities: [[Character]], positions: [Position]) -> Bool {
        let row = entities[0].count
        let column = entities.count

        for position in positions {
            if position.x < row && position.y < column {
                if let char = entities[safe: position.y, position.x] {
                    if arrayOfSymbols.contains(char) {
                        return true
                    }
                }
            }
        }
        return false
    }
}

// MARK: - Extensions

extension Array where Element: Collection {
    subscript(safe row: Int, column: Int) -> Element.Element? {
        guard row >= 0, row < self.count else {
            return nil
        }
        let subArray = self[row]
        guard column >= 0, column < subArray.count else {
            return nil
        }
        return subArray[subArray.index(subArray.startIndex, offsetBy: column)]
    }
}
