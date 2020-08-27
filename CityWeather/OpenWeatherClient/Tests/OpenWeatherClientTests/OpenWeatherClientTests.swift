import XCTest
@testable import OpenWeatherClient

final class OpenWeatherClientTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(OpenWeatherClient().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
