import XCTest
@testable import ShareIt

final class ShareItTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(ShareIt().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
