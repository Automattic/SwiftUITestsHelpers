import XCTest

extension XCTWaiter.Result: @retroactive CustomStringConvertible {

    public var description: String {
        switch self {
        case .completed: return "XCTWaiter.Result .completed"
        case .incorrectOrder: return "XCTWaiter.Result .incorrectOrder"
        case .interrupted: return "XCTWaiter.Result .interruted"
        case .invertedFulfillment: return "XCTWaiter.Result .invertedFulfillment"
        case .timedOut: return "XCTWaiter.Result .timedOut"
        @unknown default: return "XCTWaiter.Result unknown case – Please file a bug report at https://github.com/Automattic/XCUITestHelpers"
        }
    }
}
