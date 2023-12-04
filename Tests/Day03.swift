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
        XCTAssertEqual(String(describing: challenge.part1()), "503")
    }
    
    func testPart2() throws {
        let challenge = Day03(data: testData)
        XCTAssertEqual(String(describing: challenge.part2()), "0")
    }
}
