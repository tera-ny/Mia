import XCTest
@testable import Mia

final class MiaTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(Mia().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
