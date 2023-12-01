import Foundation

struct Day01: AdventDay {
    // Save your data in a corresponding text file in the `Data` directory.
    var data: String
    
    // Splits input data into its component parts and convert from string.
    var entities: [String] {
        data.split(separator: "\n").map({ String($0) })
    }
    
    func part1() -> Any {
        // Calculate the sum of the first set of input data
        return entities
            .map({ entity in
                let digits = entity.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
                
                let firstDigit = digits.first!
                let lastDigit = digits.last!
                let validDigits = digits.count == 1 ? String(repeating: digits, count: 2) : "\(firstDigit)\(lastDigit)"
                return validDigits
            })
            .map({
                Int($0) ?? 0
            })
            .reduce(0, +)
    }
    
    func part2() -> Any {
        // Sum the maximum entries in each set of data
        return entities
            .map { getNumbersFrom(string: $0) }
            .map { Int($0 ?? "0") ?? 0 }
            .reduce(0, +)
    }
}

extension Day01 {
    private func getNumbersFrom(string: String) -> String? {
        let numbers = ["zero", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine"]
        
        var left: String?
        var right: String?
        
        left = findNumber(string: string, numberWords: numbers, isReversed: false)
        let reversedString = String(string.reversed())
        if let reversedNumber = findNumber(string: reversedString, numberWords: numbers.reversed(), isReversed: true) {
            right = String(reversedNumber.reversed())
        }
        
        if left != nil, left == right {
            right = left
        }
        
        return left?.appending(right ?? "0")
    }
    
    private func findNumber(string: String, numberWords: [String], isReversed: Bool) -> String? {
        var index = string.endIndex
        var foundNumber: String?
        
        let numberMap: [String: String] = [
            "zero": "0",
            "one": "1",
            "two": "2",
            "three": "3",
            "four": "4",
            "five": "5",
            "six": "6",
            "seven": "7",
            "eight": "8",
            "nine": "9"
        ]
        
        for number in numberWords {
            let number = isReversed ? String(number.reversed()) : number
            if let foundIndex = string.range(of: number)?.lowerBound, foundIndex < index {
                index = foundIndex
                // hack: reverse the string again if it's a reverse number to perform the lookup
                foundNumber = numberMap[isReversed ? String(number.reversed()) : number]
            }
        }
        
        for i in 0..<string.count {
            let charIndex = string.index(string.startIndex, offsetBy: i)
            if string[charIndex].isNumber && charIndex < index {
                return String(string[charIndex])
            }
        }
        return foundNumber
    }
}
