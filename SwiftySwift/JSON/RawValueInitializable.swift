
import Foundation

public protocol RawValueInitializable {
    init?(rawVal: Any?)
}

extension RawValueInitializable where Self: RawRepresentable {
    public init?(rawVal: Any?) {
        guard let rawValue = rawVal as? RawValue else { return nil }
        self.init(rawValue: rawValue)
    }
}
