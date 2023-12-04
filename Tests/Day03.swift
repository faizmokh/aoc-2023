import XCTest

@testable import AdventOfCode

// Make a copy of this file for every day to ensure the provided smoke tests
// pass.
final class Day03Tests: XCTestCase {
    // Smoke test data provided in the challenge question
    let testData = """
    467..114..
    ...*......
    ..35..633.
    ......#...
    617*......
    .....+.58.
    ..592.....
    ......755.
    ...$.*....
    .664.598..
    """
    
    let testData2 = """
    12.......*..
    +.........34
    .......-12..
    ..78........
    ..*....60...
    78.........9
    .5.....23..$
    8...90*12...
    ............
    2.2......12.
    .*.........*
    1.1..503+.56
    """
    
    let testData3 = """
    ..........
    503+.56.-1
    ..........
    """
    
    let testData4 = """
    .*..........
    1.1..503+.56
    ............
    """
    
    func testPart1() throws {
        let challenge = Day03(data: testData)
        XCTAssertEqual(String(describing: challenge.part1()), "4361")
    }
    
    func testPart1_2() throws {
        let challenge = Day03(data: testData2)
        XCTAssertEqual(String(describing: challenge.part1()), "925")
    }
    
    func testPart1_3() throws {
        let challenge = Day03(data: testData3)
        XCTAssertEqual(String(describing: challenge.part1()), "504")
    }
    
    func testPart1_4() throws {
        let challenge = Day03(data: testData4)
        XCTAssertEqual(String(describing: challenge.part1()), "505")
    }
    
    func testGivenNumber_itShouldHaveTheRightAdjacents() {
        let sut = Day03.Number(value: "3", positions: [Day03.Position(x: 2, y: 2)])
        let adjacentPositions = sut.getAdjacentPositions()
        
        XCTAssertEqual(adjacentPositions.count, 8)
    }
    
    func testGivenNumber_itShouldOnlyHaveAdjacentsInsideOfBounds() {
        let sut = Day03.Number(value: "3", positions: [Day03.Position(x: 0, y: 0)])
        let adjacentPositions = sut.getAdjacentPositions()
        
        XCTAssertEqual(adjacentPositions.count, 3)
    }
    
    func testGivenNumber_itShouldNotHaveAdjacentPositionThatOverlapsWithNumber() {
        let sut = Day03.Number(value: "34", positions: [Day03.Position(x: 0, y: 0), Day03.Position(x: 1, y: 0)])
        // it should not have adjacent positions that overlap with the number
        let adjacentPositions = sut.getAdjacentPositions()
        XCTAssertFalse(adjacentPositions.contains(where: { $0.x == 1 && $0.y == 0 }))
        
        XCTAssertEqual(adjacentPositions.count, 4)
    }
    
    func testPart2() throws {
        let challenge = Day03(data: testData)
        XCTAssertEqual(String(describing: challenge.part2()), "467835")
    }
}
