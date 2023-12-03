import Foundation

/*
 
 Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
 Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue
 Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red
 Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red
 Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green

 parse above input into a dictionary of game -> [blue, green, red]
 
 */

struct Day02: AdventDay {
    // Save your data in a corresponding text file in the `Data` directory.
    var data: String
    
    struct Game {
        let id: Int
        let blue: Int
        let green: Int
        let red: Int
        
        var power: Int {
            return red * green * blue
        }
    }
    
    // Splits input data into its component parts and convert from string.
    var entities: [String] {
        data.split(separator: "\n").map({ String($0) })
    }
    
    // Replace this with your solution for the first part of the day's challenge.
    func part1() -> Any {
        let sum = entities
            .map(inputToGame(input:))
            .filter(isValid(game:))
            .map({ $0.id })
            .reduce(0, +)
        return sum
    }
    
    // Replace this with your solution for the second part of the day's challenge.
    func part2() -> Any {
        let sum = entities
            .map(inputToGame(input:))
            .map({ $0.power })
            .reduce(0, +)
        return sum
    }
}

extension Day02 {
    func inputToGame(input: String) -> Game {
        let id = getIdFrom(input: input) ?? 0
        let (red, green, blue) = getMaxRedGreenBlueFrom(input: input)
        return Game(id: id, blue: blue, green: green, red: red)
    }
    
    func getIdFrom(input: String) -> Int? {
        let components = input.components(separatedBy: CharacterSet(charactersIn: " :"))
        let gameId = components.compactMap { Int($0) }
        return gameId.first
    }
    
    func getMaxRedGreenBlueFrom(input: String) -> (red: Int, green: Int, blue: Int) {
        let components = input.components(separatedBy: CharacterSet(charactersIn: ":")).dropFirst().joined()
        let games = components.components(separatedBy: CharacterSet(charactersIn: ";"))
        
        let gamesComponent = games
            .flatMap { $0.components(separatedBy: CharacterSet(charactersIn: ",")) }
            .map { $0.trimmingCharacters(in: .whitespaces).components(separatedBy: " ") }
        
        // get the highest value of each color
        let red = gamesComponent.filter { $0.contains("red") }.flatMap({ $0 }).compactMap { Int($0) }.max() ?? 0
        let green = gamesComponent.filter { $0.contains("green") }.flatMap({ $0 }).compactMap { Int($0) }.max() ?? 0
        let blue = gamesComponent.filter { $0.contains("blue") }.flatMap({ $0 }).compactMap { Int($0) }.max() ?? 0
                
        return (red, green, blue)
    }
    
    func isValid(game: Game) -> Bool {
        return game.red <= 12 && game.green <= 13 && game.blue <= 14
    }
}
