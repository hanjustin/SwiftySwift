
import Foundation

public protocol With { }

public extension With where Self: Any {
    func with(_ block: (inout Self) -> Void) -> Self {
        var copy = self
        block(&copy)
        return copy
    }
}

extension NSObject: With { }
