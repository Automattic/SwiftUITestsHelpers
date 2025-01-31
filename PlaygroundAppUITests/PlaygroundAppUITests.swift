// Important: don't use @testable here because we want to make sure we're testing the framework
// in the same way a real world user would consume it. That is, without access to the `internal`
// methods.
import XCUITestHelpers
import XCTest

class PlaygroundAppUITests: XCTestCase {

    let app = XCUIApplication()

    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()
    }

    func testElementQueryIterator() {
        // This verifies the `XCUIElementQuery+Sequence` extension works by exercising the `forEach`
        // method the extension makes available.
        app.staticTexts.forEach {
            XCTAssertNotNil($0.value as? String)
        }
    }

    func testWaitForIsHittable() {
        let buttonNotTappedText = "button has not been tapped"
        let buttonTappedText = "button was tapped"

        XCTAssertTrue(app.staticTexts[buttonNotTappedText].exists)
        XCTAssertFalse(app.staticTexts[buttonTappedText].exists)

        let button = app.buttons["button"]
        // This is a shallow test... To make it actually verify asynchronous behavior, we should
        // make the button start as interactive and update after a few moments.
        XCTAssertTrue(button.waitForIsHittable(timeout: 10.0))

        button.tap()

        XCTAssertFalse(app.staticTexts[buttonNotTappedText].exists)
        XCTAssertTrue(app.staticTexts[buttonTappedText].exists)
    }
}
