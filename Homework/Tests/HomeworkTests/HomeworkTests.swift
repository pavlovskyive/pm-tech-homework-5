import XCTest
@testable import Homework

final class HomeworkTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(Homework().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
