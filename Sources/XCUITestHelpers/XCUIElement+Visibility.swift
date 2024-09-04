import XCTest

public extension XCUIElement {

    func isFullyVisibleOnScreen(in app: XCUIApplication = XCUIApplication()) -> Bool {
        guard exists && frame.isEmpty == false && isHittable else { return false }

        /// This is a workaround for an issue in iPadOS 18 where the first window appears empty,
        /// preventing it from containing any elements, which leads to an error.
        ///
        ///  Output: {
        ///    Window, 0x103709d50, {{0.0, 0.0}, {0.0, 0.0}}  <<<<
        ///    Window (Main), 0x103740a40, {{0.0, 0.0}, {820.0, 1180.0}}
        ///    Window, 0x103759fb0, {{0.0, 0.0}, {820.0, 1180.0}}
        ///  }
        let mainWindow
        if app.windows.element(boundBy: 0).frame.isEmpty {
            mainWindow = app.windows.element(boundBy: 1)
        } else {
            mainWindow = app.windows.element(boundBy: 0)
        }

        return mainWindow.frame.contains(frame)
    }
}
